package model;

public class Asiakas {

	private int asiakasid;
	private String etunimi, sukunimi, puhelin, sposti;
	
	public Asiakas() {
		super();
	}
	
	public Asiakas(int asiakasid, String etunimi, String sukunimi, String puhelin, String sposti) {
		super();
		this.asiakasid = asiakasid;
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puhelin = puhelin;
		this.sposti = sposti;
	}
	public int getAsiakasid() {
		return asiakasid;
	}
	public void setAsiakasid(int asiakasid) {
		this.asiakasid = asiakasid;
	}
	public String getEtunimi() {
		return etunimi;
	}
	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}
	public String getSukunimi() {
		return sukunimi;
	}
	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}
	public String getPuhelin() {
		return puhelin;
	}
	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}
	public String getSposti() {
		return sposti;
	}
	public void setSposti(String sposti) {
		this.sposti = sposti;
	}
	@Override
	public String toString() {
		return "Asiakas [asiakasid=" + asiakasid + ", etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puhelin="
				+ puhelin + ", sposti=" + sposti + "]";
	}
	
	
	
}
