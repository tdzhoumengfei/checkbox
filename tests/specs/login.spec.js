
const { test } = require("@playwright/test")
const { LoginPage } = require("../../pages/login.po")
const { UserStatePage } = require("../../pages/userState.po")
const { USER_EMAIL, USER_PASSWORD } = require("../constants/env.js")
const { beforeEachTasks } = require("../../helpers/hooks")

// eslint-disable-next-line no-empty-pattern
test.beforeEach(async ({}, testInfo ) => {
	beforeEachTasks(testInfo)
})

// eslint-disable-next-line no-empty-pattern
test.afterEach(async ({}, testInfo) => {
	console.log ("### Finished test '" + testInfo.title + "' with status: " + testInfo.status)
}) 

test("Login in Workspace", async ({ page })  => {
	const loginPage = new LoginPage(page)
	const userStatusPage = new UserStatePage(page) 
	
	await test.step("Insert Agent01 valid credentials and clicks on 'Login' button", async () => {
		await loginPage.goto()
		await loginPage.authenticate(USER_EMAIL, USER_PASSWORD)
	})

	await test.step("Agent status is available", async () => {
		await userStatusPage.waitForUserStatus("Available")
	})
})