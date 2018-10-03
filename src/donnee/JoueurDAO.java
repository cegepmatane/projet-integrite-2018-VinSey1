package donnee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import modele.Equipe;
import modele.Joueur;

public class JoueurDAO implements JoueurSQL {
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
		PreparedStatement requeteListeJoueurs;
		try {
			requeteListeJoueurs = connection.prepareStatement(SQL_LISTER_JOUEURS);
			requeteListeJoueurs.setInt(1, idEquipe);
			System.out.println("SQL : " + requeteListeJoueurs);
			ResultSet curseurListeJoueurs = requeteListeJoueurs.executeQuery();
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
		PreparedStatement requeteJoueur;
		try {
			requeteJoueur = connection.prepareStatement(SQL_RAPPORTER_JOUEUR);
			requeteJoueur.setInt(1, idJoueur);
			System.out.println("SQL : " + requeteJoueur);
			ResultSet curseurJoueur = requeteJoueur.executeQuery();
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

	public void ajouterJoueur(Joueur joueur, int idEquipe) {
		try {
			PreparedStatement requeteAjouterJoueur = connection.prepareStatement(SQL_AJOUTER_JOUEUR);
			requeteAjouterJoueur.setString(1, joueur.getNom());
			requeteAjouterJoueur.setString(2, joueur.getNationalite());
			
			requeteAjouterJoueur.setInt(3, Integer.parseInt(joueur.getNaissance()));
			requeteAjouterJoueur.setInt(4, idEquipe);
			
			System.out.println("SQL : " + requeteAjouterJoueur);
			requeteAjouterJoueur.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void modifierJoueur(Joueur joueur) {
		try {
			PreparedStatement requeteModifierJoueur = connection.prepareStatement(SQL_MODIFIER_JOUEUR);
			requeteModifierJoueur.setString(1, joueur.getNom());
			requeteModifierJoueur.setString(2, joueur.getNationalite());
			
			requeteModifierJoueur.setInt(3, Integer.parseInt(joueur.getNaissance()));
			requeteModifierJoueur.setInt(4, joueur.getId());
			
			System.out.println("SQL : " + requeteModifierJoueur);
			requeteModifierJoueur.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
