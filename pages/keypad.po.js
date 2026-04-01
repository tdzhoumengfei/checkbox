exports.KeypadPage = class KeypadPage {
	constructor(page) {
		this.page = page
		this.contentFrame = page.frameLocator("[data-testid=\"frame-conversation\"]")
		this.callButton = this.contentFrame.locator("button[data-testid=\"outbound-call-button\"]")
	}
    
	async getCallButton() {
		return await this.callButton
	}
} 
