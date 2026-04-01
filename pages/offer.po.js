exports.OfferPage = class OfferPage {
	constructor(page) {
		this.page = page 
		this.contentFrame = page.frameLocator("[data-testid=\"frame-conversation\"]")
		this.callStatus = this.contentFrame.locator("p[data-testid='call-state-text']")
		this.acceptCallButton = this.contentFrame.locator("button[data-testid='accept-call-button']")
		this.rejectCallButton = this.contentFrame.locator("button[data-testid='reject-call-button']")
	}

	async getAcceptCallButton() { 
		return await this.acceptCallButton 
	}

	async getRejectCallButton() { 
		return await this.rejectCallButton 
	}
  
	async getCallStatus() {
		return await this.callStatus.textContent()
	}

}
