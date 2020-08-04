package bbs;

import book.DAO;

public class Main {

	
	public static void main(String[] args) {
		BBSDAO dao=new BBSDAO();
		System.out.println(dao.list("writer","spider",1,5));
	}

}
