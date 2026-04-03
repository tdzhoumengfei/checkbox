const { expect } = require("@playwright/test")
const { LoginPage } = require("../../pages/login.po")
const { UserStatePage } = require("../../pages/userState.po")
const { KeypadPage } = require("../../pages/keypad.po")

exports.runSyntheticWorkspaceSmoke = async (page, email, password, expectedStatus = "Available") => {
	const loginPage = new LoginPage(page)
	const userStatusPage = new UserStatePage(page)
	const keypadPage = new KeypadPage(page)

	await loginPage.goto()
	await loginPage.authenticate(email, password)
	await userStatusPage.waitForUserStatus(expectedStatus)
	await expect(await keypadPage.getCallButton()).toBeVisible()

	return {
		loginPage,
		userStatusPage,
		keypadPage
	}
}
