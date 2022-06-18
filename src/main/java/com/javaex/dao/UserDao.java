package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {

	@Autowired
	private SqlSession sqlSession;

	public UserVo selectUserVo(UserVo userVo) {
		return sqlSession.selectOne("UsersXml.getUser", userVo);
	}

	public int insertUserVo(UserVo userVo) {
		System.out.println("---->sqlSession.selectList()");
		System.out.println(sqlSession);
		
		return sqlSession.insert("UsersXml.insert",userVo);
	}

	public UserVo selectUserVo(String id) {
		System.out.println("---->sqlSession.selectList()");
		System.out.println(sqlSession);
		
		return sqlSession.selectOne("UsersXml.idCheck",id);
	}

}
