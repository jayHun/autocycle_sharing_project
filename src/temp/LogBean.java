package temp;

public class LogBean {
	//데이터 저장하려고만든 bean입니다
	public LogBean(){}
	
	private String sumusing=null;
	private String counter=null;
	

	public void setSum(String sumusing){
		this.sumusing=sumusing;
	}
	public String getSum(){
		return this.sumusing;
	}
	public void setCounter(String counter){
		this.counter=counter;
	}
	public String getCounter(){
		return this.counter;
	}
}
