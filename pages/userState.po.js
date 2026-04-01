exports.UserStatePage = class UserStatePage {

	/**
	* @param {import('@playwright/test').Page} page
  	*/
	
	constructor(page) {
		this.page = page
		this.userStatusContainer = page.locator(".status-button-module__status-container")
	}

	async changeUserStatus(status) {
		await this.userStatusContainer.click()
		const statusLower = status.toLowerCase()
		const statusElement = this.page.locator(("a[data-testid=\"status-option-${status}\"]").replace("${status}", statusLower))
		await statusElement.click()
	}

	async waitForUserStatus(status) {
		await this.page.waitForSelector("text="+status)
	}
}