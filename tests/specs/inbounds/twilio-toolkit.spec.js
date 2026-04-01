const { test, expect } = require("@playwright/test")
const { LoginPage } = require("../../../pages/login.po")
const { UserStatePage } = require("../../../pages/userState.po")
const { OfferPage } = require("../../../pages/offer.po")
const { KeypadPage } = require("../../../pages/keypad.po")
const { USER_EMAIL, USER_PASSWORD, FROMCALLER, TOCALLER} = require("../../constants/env")
const { beforeEachTasks } = require("../../../helpers/hooks")
const { createVoiceCall } = require("../../../helpers/inbounds/twilioToolkit/twilio-toolkit-utils")

// eslint-disable-next-line no-empty-pattern
test.beforeEach(async ({}, testInfo ) => {
	beforeEachTasks(testInfo)
})

// eslint-disable-next-line no-empty-pattern
test.afterEach(async ({}, testInfo) => {
	console.log ("### Finished test '" + testInfo.title + "' with status: " + testInfo.status)
}) 

test("Twillio toolkit test case example", async ({ page })  => {
	const loginPage = new LoginPage(page)
	await loginPage.goto()
	await loginPage.authenticate(USER_EMAIL, USER_PASSWORD)

	const userStatusPage = new UserStatePage(page)
	await userStatusPage.waitForUserStatus("Available")

	const keypadPage = new KeypadPage(page)
	await expect(await keypadPage.getCallButton()).toBeVisible()

	await createVoiceCall(TOCALLER, FROMCALLER)

	const offerPage = new OfferPage(page)
	await expect(await offerPage.getCallStatus()).toEqual("Inbound call")
	await expect(await offerPage.acceptCallButton).toBeEnabled()
	await expect(await offerPage.rejectCallButton).toBeEnabled()

	await userStatusPage.waitForUserStatus("Available")
})