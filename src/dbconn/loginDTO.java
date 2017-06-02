package dbconn;

public class loginDTO {
   private String id;
   private String passwd;
   int flag = 0;
   public loginDTO(){   
   }
   
   public void setName(String ID){
      this.id = ID;
   }
   public String getName(){
      return id;
   }
   public void setPasswd(String PASSWD){
      this.passwd = PASSWD;
   }
   public String getPasswd(){
      return passwd;
   }
}