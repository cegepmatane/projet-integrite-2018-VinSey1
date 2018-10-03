package donnee;

public interface EquipeSQL {
	
	String SQL_LISTER_EQUIPES = "SELECT * FROM equipes";
	String SQL_AJOUTER_EQUIPE = "INSERT into equipes(nom, annee, region) VALUES(?, ?, ?)";
	String SQL_MODIFIER_EQUIPE = "UPDATE equipes SET nom = ?, annee = ?, region = ? WHERE id = ?";
	String SQL_RAPPORTER_EQUIPE = "SELECT * FROM equipes WHERE id = ?";

}
