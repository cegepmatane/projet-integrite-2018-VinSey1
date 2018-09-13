package action;

import java.util.ArrayList;
import java.util.List;

import donnee.EquipeDAO;
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
	protected EquipeDAO equipeDAO = null;
	
	
	public static ControleurEquipe getInstance()
	{
		if(null == instance) instance = new ControleurEquipe();
		return instance;
	}
	
	private ControleurEquipe() {
		System.out.println("Initialisation du contrôleur");
		this.equipeDAO = new EquipeDAO();
	}
	
	public void activerVues(NavigateurDesVues navigateur)
	{
		this.navigateur = navigateur;
		this.vueAjouterEquipe = navigateur.getVueAjouterEquipe();
		this.vueEquipe = navigateur.getVueEquipe();
		this.vueListeEquipe = navigateur.getVueListeEquipe();
				
		this.vueEquipe.afficherEquipe(new Equipe("Gambit", "2011", "Europe"));
		
		this.navigateur.naviguerVersVueEquipe();
		
		this.vueListeEquipe.afficherListeEquipe(equipeDAO.listerEquipes());
		
		this.navigateur.naviguerVersVueListeEquipe();
		
		this.navigateur.naviguerVersVueAjouterEquipe();
	}
	
	public void notifierEnregistrerEquipe() {
		System.out.println("ControleurEquipe.notifierEnregistreEquipe()");
		Equipe equipe = this.navigateur.getVueAjouterEquipe().demanderEquipe();
		this.equipeDAO.ajouterEquipe(equipe);
		this.navigateur.naviguerVersVueAjouterEquipe();
	}
}