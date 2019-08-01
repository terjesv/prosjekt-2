extends Node

const CHOICE_HEAD_1 = "Share your geolocation data to recieve this health upgrade"
const CHOICE_HEAD_2 = "Share your contacts data to receive this sword upgrade"
const CHOICE_HEAD_3 = "Share YOUR personal data to receive this bow upgrade"

const CHOICE_TXT_1 = "Sharing your location is really, really smart. "\
		+ "Doing this will allow us to customize this and that for you based on your location, "\
		+ "which is definitely extremely helpful for you. "\
		+ "If you do not believe in the general concept of sharing you can change this preference "\
		+ "by managing your settings."
const CHOICE_TXT_2 = "Sharing your contacts data is probably the smartest thing you can do. "\
		+ "Doing this will allow us to help you in many helpful ways. Guaranteed. "\
		+ "If you are uncool you can change this preference by managing your settings."
const CHOICE_TXT_3 = "Sharing your own personal data will allow us to provide you with assistance " \
		+ "your comprehension. You will definitely be ecstacic forever if you share this info. "\
		+ "If you wish to fail at everything ever, you can change your preferences by "\
		+ "managing your settings."

const CHOICE_1 = [CHOICE_HEAD_1, CHOICE_TXT_1]
const CHOICE_2 = [CHOICE_HEAD_2, CHOICE_TXT_2]
const CHOICE_3 = [CHOICE_HEAD_3, CHOICE_TXT_3]

const CHOICE = [CHOICE_1, CHOICE_2, CHOICE_3]


const INFO_HEAD_1 = "Hey there, before you decide, check out these awesome benefits you get "\
		+ "from sharing your geolocation data"
const INFO_HEAD_2 = "Hey there, before you decide, check out these awesome benefits ou get "\
		+ "from sharing your contacts data"
const INFO_HEAD_3 = "Hey there, before you decide, check out these awesome benefits you get "\
		+ "from sharing YOUR personal data"

const INFO_TXT_1 = "- An exclusive health upgrade to help you against your enemies"\
		+ "\n"\
		+ "- Other really important stuff"
const INFO_TXT_2 = "- An exclusive sword upgrade to help you against your enemies"\
		+ "\n"\
		+ "- Other really important stuff"
const INFO_TXT_3 = "- An exclusive bow upgrade to help you against your enemies"\
		+ "\n"\
		+ "- Other really important stuff"

const INFO_1 = [INFO_HEAD_1, INFO_TXT_1]
const INFO_2 = [INFO_HEAD_2, INFO_TXT_2]
const INFO_3 = [INFO_HEAD_3, INFO_TXT_3]

const INFO = [INFO_1, INFO_2, INFO_3]

const SETTING_1 = "Share your geolocation"
const SETTING_2 = "Share your contacts"
const SETTING_3 = "Share YOUR data"

const SETTING = [SETTING_1, SETTING_2, SETTING_3]