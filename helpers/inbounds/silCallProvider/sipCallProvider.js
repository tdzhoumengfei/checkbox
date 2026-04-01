const axios = require("axios")
const { CALL_PROVIDER_API_URL } = require("../../../tests/constants/env")
// Note: When running the test local (without docker), the value of the var CALL_PROVIDER_API_URL will came from the script "test:local" (package.json)

const startInboundCall = async(toCaller, fromCaller) => {
	axios.post(CALL_PROVIDER_API_URL + "/start", {
		to: toCaller , from: fromCaller
	}, {
		headers: {
			"content-type": "application/json"
		} 
	})
		.then((response) => {
			console.log(response)
		})
		.catch((error) => {
			console.error(error)
		})
}

const finishCall = async() => {
	axios.post(CALL_PROVIDER_API_URL + "/finish")
		.then((response) => {
			console.log(response)
		})
		.catch((error) => {
			console.error(error)
		})
}

module.exports = {
	startInboundCall, finishCall 
}