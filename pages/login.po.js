exports.LoginPage = class LoginPage {
	
	constructor(page){
		this.page = page
		this.email = page.locator("input[type='email']")    
		this.password = page.locator("input[type='password']")       
		this.loginButton = page.locator("button", { hasText: "Login" })
	}  

	async goto() {
		await this.page.goto("/", {waitUntil:"load"})
	}

	async authenticate(email,password){
		await this.email.type(email)
		await this.password.type(password)        
		await Promise.all([
			await this.loginButton.click(),
			await this.page.waitForNavigation()
		])
		try{
			await this.page.locator("[data-testid=\"user-avatar\"]"),
			await this.page.locator("button[name='notification-badge-button-title-bar']")
		}catch{
			const frame = this.page.$$("iframe")[0]
			await frame.locator(".co-button co--primary co--white", { hasText:"Refresh" }).click()
			await this.page.locator("[data-testid=\"user-avatar\"]"),
			await this.page.locator("button[name='notification-badge-button-title-bar']")
		}       
	}
}
