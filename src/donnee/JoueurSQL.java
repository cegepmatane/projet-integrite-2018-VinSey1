package donnee;

public interface JoueurSQL {
	
	String SQL_LISTER_JOUEURS = "SELECT * FROM joueur WHERE equipe = ?";
	String SQL_AJOUTER_JOUEUR = "INSERT into joueur(nom, nationalite, naissance, equipe) VALUES(?, ?, ?, ?)";
	String SQL_MODIFIER_JOUEUR = "UPDATE joueur SET nom = ?, nationalite = ?, naissance = ? WHERE id = ?";
	String SQL_RAPPORTER_JOUEUR = "SELECT * FROM joueur WHERE id = ?";

}
