package temp;

public class RideInfoBean {
	//데이터 저장하려고만든 bean입니다
	public RideInfoBean(){}
	private String userId;
	private String startLocLat;
	private String startLocLng;
	private String endLocLat;
	private String endLocLng;
	private long startTime;
	private long endTime;
	private long usingTime;
	
	public void setUserId(String id){
		this.userId= id;
	}
	public String getUserid(){
		return this.userId;
	}
	public void setUsingTime(long time){
		this.usingTime= time;
	}
	public long getUsingTime(){
		return usingTime;
	}
	public void setStartTime(long time){
		this.startTime=time; 
	}
	public void setEndTime(long time){
		this.endTime=time;
	}
	public void setStartLocLat(String startLocLat){
		this.startLocLat= startLocLat;
	}
	public void setStartLocLng(String startLocLng){
		this.startLocLng= startLocLng;
	}
	public void setEndLocLat(String endLocLat){
		this.endLocLat=endLocLat;
	}
	public void setEndLocLng(String endLocLng){
		this.endLocLng = endLocLng;
	}
	public long getStartTime(){
		return this.startTime;
	}
	public long getEndTime(){
		return this.endTime;
	}
	public String getStartLocLat(){
		return this.startLocLat;
	}
	public String getStartLocLng(){
		return this.startLocLng;
	}
	public String getEndLocLat(){
		return this.endLocLat;
	}
	public String getEndLocLng(){
		return this.endLocLng;
	}
}
