// @ts-check
const { allure } = require("allure-playwright")

exports.beforeEachTasks = (testInfo) => {
	console.log ("### Running test '" + testInfo.title + "'")
	allure.feature("Environment: QA")
}