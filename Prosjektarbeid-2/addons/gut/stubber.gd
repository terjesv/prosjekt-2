# {
# 	inst_id_or_path1:{
# 		method_name1: [StubParams, StubParams],
# 		method_name2: [StubParams, StubParams]
# 	},
# 	inst_id_or_path2:{
# 		method_name1: [StubParams, StubParams],
# 		method_name2: [StubParams, StubParams]
# 	}
# }
var returns = {}
var _gut = null
var _utils = load('res://addons/gut/utils.gd').new()

func _is_instance(obj):
	return typeof(obj) == TYPE_OBJECT and !obj.has_method('new')

func _make_key_from_metadata(doubled):
	var to_return = doubled.__gut_metadata_.path
	if(doubled.__gut_metadata_.subpath != ''):
		to_return += str('-', doubled.__gut_metadata_.subpath)
	return to_return

# Creates they key for the returns hash based on the type of object passed in
# obj could be a string of a path to a script with an optional subpath or
# it could be an instance of a doubled object.
func _make_key_from_variant(obj, subpath=null):
	var to_return = null

	match typeof(obj):
		TYPE_STRING:
			# this has to match what is done in _make_key_from_metadata
			to_return = obj
			if(subpath != null):
				to_return += str('-', subpath)
		TYPE_OBJECT:
			if(_is_instance(obj)):
				to_return = _make_key_from_metadata(obj)
			else:
				to_return = obj.resource_path
	return to_return

func _add_obj_method(obj, method, subpath=null):
	var key = _make_key_from_variant(obj, subpath)
	if(_is_instance(obj)):
		key = obj

	if(!returns.has(key)):
		returns[key] = {}
	if(!returns[key].has(method)):
		returns[key][method] = []

	return key

# ##############
# Public
# ##############

# TODO: This method is only used in tests and should be refactored out.  It
# does not support inner classes and isn't helpful.
func set_return(obj, method, value, parameters=null):
	var key = _add_obj_method(obj, method)
	var sp = _utils.StubParams.new(key, method)
	sp.parameters = parameters
	sp.return_val = value
	returns[key][method].append(sp)

func add_stub(stub_params):
	var key = _add_obj_method(stub_params.stub_target, stub_params.stub_method, stub_params.target_subpath)
	returns[key][stub_params.stub_method].append(stub_params)

# Gets a stubbed return value for the object and method passed in.  If the
# instance was stubbed it will use that, otherwise it will use the path and
# subpath of the object to try to find a value.
#
# It will also use the optional list of parameter values to find a value.  If
# the objet was stubbed with no parameters than any parameters will match.
# If it was stubbed with specific paramter values then it will try to match.
# If the parameters do not match BUT there was also an empty paramter list stub
# then it will return those.
# If it cannot find anything that matches then null is returned.for
#
# Parameters
# obj:  this should be an instance of a doubled object.
# method:  the method called
# paramters:  optional array of paramter vales to find a return value for.
func get_return(obj, method, parameters=null):
	var key = _make_key_from_variant(obj)
	var to_return = null

	if(_is_instance(obj)):
		if(returns.has(obj) and returns[obj].has(method)):
			key = obj
		elif(obj.get('__gut_metadata_')):
			key = _make_key_from_metadata(obj)

	if(returns.has(key) and returns[key].has(method)):
		var param_idx = -1
		var null_idx = -1

		for i in range(returns[key][method].size()):
			if(returns[key][method][i].parameters == parameters):
				param_idx = i
			if(returns[key][method][i].parameters == null):
				null_idx = i

		if(param_idx != -1):
			to_return = returns[key][method][param_idx].return_val
		elif(null_idx != -1):
			to_return = returns[key][method][null_idx].return_val

	return to_return

func get_gut():
	return _gut

func set_gut(gut):
	_gut = gut

func clear():
	returns.clear()

func to_s():
	var text = ''
	for thing in returns:
		text += str(thing) + "\n"
		for method in returns[thing]:
			text += str("\t", method, "\n")
			for i in range(returns[thing][method].size()):
				text += "\t\t" + returns[thing][method][i].to_s() + "\n"
	return text
