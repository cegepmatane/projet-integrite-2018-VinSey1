package modele;

public class Joueur {
	
	protected int id;
	protected String nom;
	protected String nationalite;
	protected String naissance;
	
	public Joueur(String nom, String nationalite, String naissance) {
		this.nom = nom;
		this.nationalite = nationalite;
		this.naissance = naissance;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getNationalite() {
		return nationalite;
	}

	public void setNationalite(String nationalite) {
		this.nationalite = nationalite;
	}

	public String getNaissance() {
		return naissance;
	}

	public void setNaissance(String naissance) {
		this.naissance = naissance;
	}

}
