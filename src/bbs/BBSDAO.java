package bbs;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class BBSDAO {
	//게시글 읽기
	public BBSVO read(int seqno) {
		BBSVO vo = new BBSVO();
		try {
			String sql="select * from bbs where seqno=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1,seqno);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setContent(rs.getString("content"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setSeqno(rs.getInt("seqno"));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
				vo.setWdate(sdf.format(rs.getTimestamp("wdate")));
			}
		}catch (Exception e) {
			System.out.println("게시글읽기 : " + e.toString());
		}
		return vo;
	}
	//게시판 글쓰기
	public boolean insert(BBSVO vo){
		boolean success=false;
		try {
			String sql="insert into bbs(title,writer,content) values(?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getWriter());
			ps.setString(3, vo.getContent());
			ps.execute();
			success=true;	
			
		}catch (Exception e) {
			success=false;
			System.out.println("게시판 글쓰기 :" + e.toString());
		}
		return false;
	}
	
	//게시판 목록
	public JSONObject list(String key, String word, int page, int perPage) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="call list('bbs',?,?,'seqno','desc',?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, key);
			cs.setString(2, word);
			cs.setInt(3, (page-1)*perPage);
			cs.setInt(4, perPage);		
			cs.execute();
			
	
			JSONArray jArray=new JSONArray();
			ResultSet rs=cs.getResultSet();
			
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("seqno", rs.getInt("seqno"));
				obj.put("title", rs.getString("title"));
				obj.put("writer", rs.getString("writer"));
				obj.put("content", rs.getString("content"));
				obj.put("wdate", rs.getString("wdate"));
				jArray.add(obj);
			}
			jObject.put("list", jArray);
			
			cs.getMoreResults(); //다음 result로 이동
			int count=0;
			rs=cs.getResultSet();
			if(rs.next()) {
				count=rs.getInt("total");
			}
			
			jObject.put("count",count);
			jObject.put("page", page);
			jObject.put("perPage", perPage);
			int totPage=count%perPage==0?count/perPage:(count/perPage)+1;
			jObject.put("totPage", totPage);
			
		}catch(Exception e) {
			System.out.println("게시판 목록 : " + e.toString());
		}
		return jObject;
	}
}
