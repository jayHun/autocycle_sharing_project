package temp;
import java.util.ArrayList;

public class BikeBean {
	public BikeBean(){}
	
	private ArrayList<String> bikeId;
	private ArrayList<String> latitude;
	private ArrayList<String> longitude;
	private String curLocationLat;
	private String curLocationLng;
	
	public String getCurLocationLat(){
		return this.curLocationLat;
	}
	public String getCurLocationLng(){
		return this.curLocationLng;
	}
	public String[] getBikeId(){
		return bikeId.toArray(new String[bikeId.size()]);
	}
	
	public String[] getLatitude(){
		return latitude.toArray(new String[latitude.size()]);
	}
	public String[] getLongitude(){
		return longitude.toArray(new String[longitude.size()]);
	}
	
	public void setCurLocationLng(String lng){
		this.curLocationLng=lng;
	}
	public void setCurLocationLat(String lat){
		this.curLocationLat= lat;
	}
	public void setBikeId(int index,String bikeId){
		this.bikeId.add(index, bikeId);
	}
	public void setLatitude(int index, String latitude){
		this.latitude.add(index, latitude);
	}
	public void setLongitude(int index,String longitude){
		this.latitude.add(index,longitude);
	}
}
