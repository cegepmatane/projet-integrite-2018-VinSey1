package donnee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import modele.Equipe;
import modele.Joueur;

public class JoueurDAO {
	private static String BASEDEDONNEES_DRIVER = "org.postgresql.Driver";
	private static String BASEDEDONNEES_URL = "jdbc:postgresql://localhost:5432/projet-integrite-2018-VinSey1";
	private static String BASEDEDONNEES_USAGER = "postgres";
	private static String BASEDEDONNEES_MOTDEPASSE = "05111998";
	private Connection connection = null;
	
	public JoueurDAO() {
		try {
			Class.forName(BASEDEDONNEES_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			connection = DriverManager.getConnection(BASEDEDONNEES_URL, BASEDEDONNEES_USAGER, BASEDEDONNEES_MOTDEPASSE);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<Joueur> listerJoueurs(int idEquipe){
		List<Joueur> listeJoueurs = new ArrayList<Joueur>();
		Statement requeteListeJoueurs;
		try {
			requeteListeJoueurs = connection.createStatement();
			ResultSet curseurListeJoueurs = requeteListeJoueurs.executeQuery("SELECT * FROM joueur WHERE equipe = "+idEquipe);
			while (curseurListeJoueurs.next()){
				int id = curseurListeJoueurs.getInt("id");
				String nom = curseurListeJoueurs.getString("nom");
				String naissance = curseurListeJoueurs.getString("naissance");
				String nationalite = curseurListeJoueurs.getString("nationalite");
				
				Joueur joueur = new Joueur(nom, nationalite, naissance);
				joueur.setId(id);
				listeJoueurs.add(joueur);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return listeJoueurs;
	}
	
	public Joueur rapporterJoueur(int idJoueur) {
		Statement requeteJoueur;
		try {
			requeteJoueur = connection.createStatement();
			String SQL_RAPPORTER_JOUEUR = "SELECT * FROM joueur WHERE id = "+idJoueur;
			ResultSet curseurJoueur = requeteJoueur.executeQuery(SQL_RAPPORTER_JOUEUR);
			curseurJoueur.next();
			int id = curseurJoueur.getInt("id");
			String nom = curseurJoueur.getString("nom");
			String naissance = curseurJoueur.getString("naissance");
			String nationalite = curseurJoueur.getString("nationalite");
			Joueur joueur = new Joueur(nom, nationalite, naissance);
			joueur.setId(id);
			return joueur;			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

}
