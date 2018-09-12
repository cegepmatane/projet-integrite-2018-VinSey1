package accesseur;

import java.util.ArrayList;
import java.util.List;

import modele.Equipe;

public class EquipeDAO {
	
	private List<Equipe> simulerListeEquipe(){
		List listeEquipesTest = new ArrayList<Equipe>();
		listeEquipesTest.add(new Equipe("Fnatic", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("Gambit", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("SKT", "2013", "Corée"));
		return listeEquipesTest;
	}
	
	public List<Equipe> listerEquipes(){
		return this.simulerListeEquipe();
	}
}