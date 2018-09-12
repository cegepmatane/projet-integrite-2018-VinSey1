package controleur;

import java.util.ArrayList;
import java.util.List;

import modele.Equipe;
import vue.NavigateurDesVues;
import vue.VueAjouterEquipe;
import vue.VueEquipe;
import vue.VueListeEquipe;

public class ControleurEquipe {
	
	private static ControleurEquipe instance = null;

	private NavigateurDesVues navigateur;
	private VueAjouterEquipe vueAjouterEquipe = null;
	private VueListeEquipe vueListeEquipe = null;
	private VueEquipe vueEquipe = null;
	
	
	public static ControleurEquipe getInstance()
	{
		if(null == instance) instance = new ControleurEquipe();
		return instance;
	}
	
	private ControleurEquipe() {
		System.out.println("Initialisation du contrôleur");
	}
	
	public void activerVues(NavigateurDesVues navigateur)
	{
		this.navigateur = navigateur;
		this.vueAjouterEquipe = navigateur.getVueAjouterEquipe();
		this.vueEquipe = navigateur.getVueEquipe();
		this.vueListeEquipe = navigateur.getVueListeEquipe();
				
		this.vueEquipe.afficherEquipe(new Equipe("Gambit", "2011", "Europe"));
		
		this.navigateur.naviguerVersVueEquipe();
		
		List listeEquipesTest = new ArrayList<Equipe>();
		listeEquipesTest.add(new Equipe("Fnatic", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("Gambit", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("SKT", "2013", "Corée"));
		this.vueListeEquipe.afficherListeEquipe(listeEquipesTest);
		
		this.navigateur.naviguerVersVueListeEquipe();
		
		this.navigateur.naviguerVersVueAjouterEquipe();
	}
}