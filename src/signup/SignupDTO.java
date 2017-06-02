package signup;


public class SignupDTO {
	private String id;
	private String passwd;
	private String name;
	private String hp;
	private String birth;
	
	
	public void setId(String id){
		this.id=id;
	}
	public String getId() {
		return id;
	}
	
	public void setName(String name){
		this.name=name;
	}
	public String getName() {
		return name;
	}
	
	public void setHp(String hp){
		this.hp=hp;
	}
	public String getHp() {
		return hp;
	}
	
	public void setBirth(String birth){
		this.birth=birth;
	}
	public String getBirth() {
		return birth;
	}

	public void setPasswd(String passwd){
		this.passwd=passwd;
	}
	public String getPasswd() {
		return passwd;
	}
}
