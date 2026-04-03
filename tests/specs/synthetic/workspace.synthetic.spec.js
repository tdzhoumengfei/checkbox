const { test, expect } = require("@playwright/test")
const { beforeEachTasks } = require("../../../helpers/hooks")
const { USER_EMAIL, USER_PASSWORD } = require("../../constants/env")
const { runSyntheticWorkspaceSmoke } = require("../../../helpers/synthetic/smoke-flow")

test.beforeEach(async ({}, testInfo ) => {
	beforeEachTasks(testInfo)
})

test.afterEach(async ({}, testInfo) => {
	console.log ("### Finished test '" + testInfo.title + "' with status: " + testInfo.status)
})

test.describe("[synthetic browser] Workspace navigation smoke @Workspace @synthetic", () => {
	test("QAG-1539 workspace navigation synthetic", async ({ page }) => {
		let syntheticState

		await test.step("[Action] Login and land in workspace", async () => {
			syntheticState = await runSyntheticWorkspaceSmoke(page, USER_EMAIL, USER_PASSWORD)
		})

		await test.step("[Action] Refresh workspace and validate controls", async () => {
			await page.reload({ waitUntil: "load" })
			await expect(page.locator("[data-testid='frame-conversation']")).toBeVisible()
		})

		await test.step("[Validation] Outbound call control is visible after navigation", async () => {
			const { keypadPage, userStatusPage } = syntheticState
			await userStatusPage.waitForUserStatus("Available")
			await expect(await keypadPage.getCallButton()).toBeVisible()
		})
	})
})
