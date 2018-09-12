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
	
	private List<Equipe> simulerListeEquipe(){
		List listeEquipesTest = new ArrayList<Equipe>();
		listeEquipesTest.add(new Equipe("Fnatic", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("Gambit", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("SKT", "2013", "Cor�e"));
		return listeEquipesTest;
	}
	
	public List<Equipe> listerEquipes(){
		String BASEDEDONNEES_DRIVER = "org.postgresql.Driver";
		String BASEDEDONNEES_URL = "jdbc:postgresql://localhost:5432/projet-integrite-2018-VinSey1";
		String BASEDEDONNEES_USAGER = "postgres";
		String BASEDEDONNEES_MOTDEPASSE = "05111998";
		
		try {
			Class.forName(BASEDEDONNEES_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			Connection connection = DriverManager.getConnection(BASEDEDONNEES_URL, BASEDEDONNEES_USAGER, BASEDEDONNEES_MOTDEPASSE);
			Statement requeteListeEquipes = connection.createStatement();
			ResultSet curseurListeEquipes = requeteListeEquipes.executeQuery("SELECT * FROM equipes");
			curseurListeEquipes.next();
			String nom = curseurListeEquipes.getString("nom");
			String anneDeCreation = curseurListeEquipes.getString("annee");
			String region = curseurListeEquipes.getString("region");
			System.out.println("�quipe " + nom + " cr��e le " + anneDeCreation + " en " + region);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return this.simulerListeEquipe();
	}
}