package donnee;

import java.util.ArrayList;
import java.util.List;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import modele.Equipe;

public class EquipeDAO {
	
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
		Statement requeteListeEquipes;
		try {
			requeteListeEquipes = connection.createStatement();
			ResultSet curseurListeEquipes = requeteListeEquipes.executeQuery("SELECT * FROM equipes");
			while(curseurListeEquipes.next()) {
				int id = curseurListeEquipes.getInt("id");
				String nom = curseurListeEquipes.getString("nom");
				String anneDeCreation = curseurListeEquipes.getString("annee");
				String region = curseurListeEquipes.getString("region");
				System.out.println("Équipe " + nom + " créée le " + anneDeCreation + " en " + region);
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
		System.out.println("EquipeDAO.ajouterEquipe()");
		try {
			Statement requeteAjouterEquipe = connection.createStatement();
			requeteAjouterEquipe.execute("INSERT into equipes(nom, annee, region) VALUES('"+equipe.getNom()+"','"+equipe.getAnneeDeCreation()+"','"+equipe.getRegion()+"')");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Equipe rapporterEquipe(int idEquipe) {
		Statement requeteEquipe;
		try {
			requeteEquipe = connection.createStatement();
			String SQL_RAPPORTER_EQUIPE = "SELECT * FROM equipes WHERE id = "+idEquipe;
			ResultSet curseurEquipe = requeteEquipe.executeQuery(SQL_RAPPORTER_EQUIPE);
			curseurEquipe.next();
			int id = curseurEquipe.getInt("id");
			String nom = curseurEquipe.getString("nom");
			String anneDeCreation = curseurEquipe.getString("annee");
			String region = curseurEquipe.getString("region");
			System.out.println("Équipe " + nom + " créée le " + anneDeCreation + " en " + region);
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
			Statement requeteModifierEquipe = connection.createStatement();
			String SQL_MODIFIER_EQUIPE = "UPDATE equipes SET nom = '"+equipe.getNom()+"', annee = '"+equipe.getAnneeDeCreation()+"', region = '"+equipe.getRegion()+"' WHERE id = " + equipe.getId();
			requeteModifierEquipe.execute(SQL_MODIFIER_EQUIPE);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}