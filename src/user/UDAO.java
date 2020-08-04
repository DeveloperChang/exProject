package user;

import java.sql.*;

import org.json.simple.*;

import bbs.Database;

public class UDAO {
	//ȸ������
	public JSONObject insert(UserVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "call add_user(?,?,?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, vo.getId());
			cs.setString(2, vo.getPassword());
			cs.setString(3, vo.getName());
			cs.registerOutParameter(4, java.sql.Types.INTEGER);
			cs.execute();
			jObject.put("count", cs.getInt(4));
			
		}catch(Exception e){
			System.out.println("ȸ������ : " + e.toString() );
		}
		return jObject;
	}
	//�α��� üũ
	public UserVO loginCheck(String id,String password) {
		UserVO vo = new UserVO();
		try {
			String sql = "select * from userinfo where id=? and password=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setName(rs.getString("name"));
				vo.setId(rs.getString("id"));
			}
		}catch(Exception e) {
			System.out.println("�α��� üũ : " + e.toString());
		}
		return vo;
	}
	
	//����������
	public JSONObject list(String key, String word, int page, int perPage) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="call list('userinfo',?,?,'id','',?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, key);
			cs.setString(2, word);
			cs.setInt(3, (page-1)*perPage);
			cs.setInt(4, perPage);
			cs.execute();
			

			ResultSet rs=cs.getResultSet();
			JSONArray array=new JSONArray();
			
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("name", rs.getString("name"));
				obj.put("id", rs.getString("id"));
				obj.put("job", rs.getString("job"));
				obj.put("tel", rs.getString("tel"));
				array.add(obj);
			}
			jObject.put("array", array);
			
			cs.getMoreResults(); //���� result�� �̵�
			rs=cs.getResultSet();
			int count=0;
			
			if(rs.next()) {
				count=rs.getInt("total");
			}
			jObject.put("count",count); //��ü �˻���
			jObject.put("page",(page-1)*perPage); //����������
			jObject.put("perPage",perPage); //�� �������� ��µ� ����
			int totPage=count%perPage==0?count/perPage:count/perPage+1;
			jObject.put("totPage",totPage);
			
		}catch(Exception e) {
			System.out.println("������� : " + e.toString());
		}return jObject;
	}
}
