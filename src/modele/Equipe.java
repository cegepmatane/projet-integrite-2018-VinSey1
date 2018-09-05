package modele;

public class Equipe {
	
	protected String nom;
	protected String anneeDeCreation;
	protected String region;

	public Equipe(String nom, String anneeDeCreation, String region) {
		this.nom = nom;
		this.anneeDeCreation = anneeDeCreation;
		this.region = region;
	}
	
	public String getNom() {
		return nom;
	}
	
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	public String getAnneeDeCreation() {
		return anneeDeCreation;
	}
	
	public void setAnneeDeCreation(String anneeDeCreation) {
		this.anneeDeCreation = anneeDeCreation;
	}
	
	public String getRegion() {
		return region;
	}
	
	public void setRegion(String region) {
		this.region = region;
	}
}
