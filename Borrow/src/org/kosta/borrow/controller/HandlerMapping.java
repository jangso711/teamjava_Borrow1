package org.kosta.borrow.controller;

public class HandlerMapping {
	private static HandlerMapping instance= new HandlerMapping();
	private HandlerMapping() {}
	public static HandlerMapping getInstance() {
		return instance;
	}
	public Controller create(String command) {
		Controller controller = null;
		if(command.equals("Main")) {
			controller = new MainController();
		}else if(command.equals("Login")) {
			controller = new LoginController();
		}else if(command.equals("LoginForm")) {
			controller = new LoginFormController();
		}else if(command.equals("Logout")) {
			controller = new LogoutController();
		}else if(command.equals("MemberRegisterForm")) {
			controller = new MemberRegisterFormController();
		}else if(command.equals("MemberRegister")) {
			controller = new MemberRegisterController();
		}else if(command.equals("MemberUpdateForm")) {
			controller = new MemberUpdateFormController();
		}else if(command.equals("MemberUpdate")) {
			controller = new MemberUpdateController();
		}else if(command.equals("MemberDetail")) {
			controller = new MemberDetailController();
		}else if(command.equals("MemberMypage")) {
			controller = new MemberMypageController();
		}else if(command.equals("ItemSearch")) {
			controller = new ItemSearchController();
		}else if(command.equals("ItemAllSearch")) {
			controller = new ItemAllSearchController();
		}else if(command.equals("ItemDetail")) {
			controller = new ItemDetailController();
		}else if(command.equals("ItemRegisterForm")) {
			controller = new ItemRegisterFormController();
		}else if(command.equals("ItemRegister")) {
			controller = new ItemRegisterController();
		}else if(command.equals("ItemUpdateForm")) {
			controller = new ItemUpdateFormController();
		}else if(command.equals("ItemUpdate")) {
			controller = new ItemUpdateController();
		}else if(command.equals("ItemDelete")) {
			controller = new ItemDeleteController();
		}else if(command.equals("ItemRentDetail")) {
			controller = new ItemRentDetailController();
		}else if(command.equals("ItemRentalList")) {
			controller = new ItemRentalListController();
		}else if(command.equals("ItemRegisterList")) {
			controller = new ItemRegisterListController();
		}
		
		return controller;
	}
}
