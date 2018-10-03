package donnee;

import java.util.ArrayList;
import java.util.List;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import modele.Equipe;

public class EquipeDAO implements EquipeSQL {
	
	/*private List<Equipe> simulerListeEquipe(){
		List listeEquipesTest = new ArrayList<Equipe>();
		listeEquipesTest.add(new Equipe("Fnatic", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("Gambit", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("SKT", "2013", "Corée"));
		return listeEquipesTest;
	}*/
	
	private static String BASEDEDONNEES_DRIVER = "org.postgresql.Driver";
	private static String BASEDEDONNEES_URL = "jdbc:postgresql://localhost:5432/projet-integrite-2018-VinSey1";
	private static String BASEDEDONNEES_USAGER = "postgres";
	private static String BASEDEDONNEES_MOTDEPASSE = "05111998";
	private Connection connection = null;
	
	public EquipeDAO() {		
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
		
	public List<Equipe> listerEquipes(){
		List<Equipe> listeEquipes = new ArrayList<Equipe>();
		PreparedStatement requeteListeEquipes;
		try {
			requeteListeEquipes = connection.prepareStatement(SQL_LISTER_EQUIPES);
			System.out.println("SQL : " + requeteListeEquipes);

			ResultSet curseurListeEquipes = requeteListeEquipes.executeQuery();
			while(curseurListeEquipes.next()) {
				int id = curseurListeEquipes.getInt("id");
				String nom = curseurListeEquipes.getString("nom");
				String anneDeCreation = curseurListeEquipes.getString("annee");
				String region = curseurListeEquipes.getString("region");
				Equipe equipe = new Equipe(nom, anneDeCreation, region);
				equipe.setId(id);
				listeEquipes.add(equipe);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listeEquipes;
	}
	
	public void ajouterEquipe(Equipe equipe) {
		try {
			PreparedStatement requeteAjouterEquipe = connection.prepareStatement(SQL_AJOUTER_EQUIPE);
			requeteAjouterEquipe.setString(1, equipe.getNom());
			requeteAjouterEquipe.setString(2, equipe.getAnneeDeCreation());
			requeteAjouterEquipe.setString(3, equipe.getRegion());
			
			System.out.println("SQL : " + requeteAjouterEquipe);
			requeteAjouterEquipe.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Equipe rapporterEquipe(int idEquipe) {
		PreparedStatement requeteEquipe;
		try {
			requeteEquipe = connection.prepareStatement(SQL_RAPPORTER_EQUIPE);
			requeteEquipe.setInt(1, idEquipe);
			System.out.println("SQL : " + requeteEquipe);
			ResultSet curseurEquipe = requeteEquipe.executeQuery();
			curseurEquipe.next();
			int id = curseurEquipe.getInt("id");
			String nom = curseurEquipe.getString("nom");
			String anneDeCreation = curseurEquipe.getString("annee");
			String region = curseurEquipe.getString("region");
			Equipe equipe = new Equipe(nom, anneDeCreation, region);
			equipe.setId(id);
			return equipe;			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	public void modifierEquipe(Equipe equipe) {
		try {
			PreparedStatement requeteModifierEquipe = connection.prepareStatement(SQL_MODIFIER_EQUIPE);
			requeteModifierEquipe.setString(1, equipe.getNom());
			requeteModifierEquipe.setString(2, equipe.getAnneeDeCreation());
			requeteModifierEquipe.setString(3, equipe.getRegion());
			requeteModifierEquipe.setInt(4, equipe.getId());
			
			System.out.println("SQL : " + requeteModifierEquipe);
			requeteModifierEquipe.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}