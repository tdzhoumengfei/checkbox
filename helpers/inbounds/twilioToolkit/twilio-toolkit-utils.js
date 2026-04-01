const setup = require("@talkdesk/twilio-toolkit")
const { TWILIO_TOOLKIT_ACCOUNTSID, TWILIO_TOOLKIT_AUTHTOKEN } = require("../../../tests/constants/env")
const fs = require("fs/promises")
const path = require("path")

const createVoiceCall = async (toNumber, fromNumber) => {
	const twilio = setup({ 
		accountSID: TWILIO_TOOLKIT_ACCOUNTSID,
		authToken: TWILIO_TOOLKIT_AUTHTOKEN,
		fromNumber: fromNumber
	})

	const script = await fs.readFile(path.join(__dirname, "./twilio-inbound-script.xml"))
	return new Promise((resolve, reject) => {
		try {
			twilio.createVoiceCall(toNumber, script)
				.then((response) => {
					console.log(`Call created with SID: ${response.data.sid}`)
					resolve(response.data.sid)
				})
				.catch((error) => {
					reject({
						status: error
					})
				})
		}
		catch (err) {
			console.error(err.message)
		}
	})
}

module.exports = { createVoiceCall }