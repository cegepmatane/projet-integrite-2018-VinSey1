package action;

import java.util.ArrayList;
import java.util.List;

import donnee.EquipeDAO;
import modele.Equipe;
import modele.Joueur;
import vue.NavigateurDesVues;
import vue.VueAjouterEquipe;
import vue.VueEditerEquipe;
import vue.VueEquipe;
import vue.VueListeEquipe;

public class ControleurEquipe {
	
	private static ControleurEquipe instance = null;

	private NavigateurDesVues navigateur;
	private VueAjouterEquipe vueAjouterEquipe = null;
	private VueListeEquipe vueListeEquipe = null;
	private VueEquipe vueEquipe = null;
	protected EquipeDAO equipeDAO = null;
	private VueEditerEquipe vueEditerEquipe = null;
	
	
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
		this.vueEditerEquipe = navigateur.getVueEditerEquipe();
				
		this.vueEquipe.afficherEquipe(new Equipe("Gambit", "2011", "Europe"));
		
		this.navigateur.naviguerVersVueEquipe();
		
		this.vueListeEquipe.afficherListeEquipe(equipeDAO.listerEquipes());
		
		this.navigateur.naviguerVersVueListeEquipe();
		
		//this.navigateur.naviguerVersVueAjouterEquipe();
		
		List<Joueur> listeJoueurs = new ArrayList<Joueur>();
		Joueur joueur;
		joueur = new Joueur("Valentin", "France", "04/11/1994");
		listeJoueurs.add(joueur);
		joueur = new Joueur("Vincent", "France", "05/11/1998");
		listeJoueurs.add(joueur);		
		joueur = new Joueur("Michaël", "Canada", "?/?/?");
		listeJoueurs.add(joueur);		
		joueur = new Joueur("Eliott", "France", "?/?/?");
		listeJoueurs.add(joueur);		
		joueur = new Joueur("Youssef", "France", "?/?/?");
		listeJoueurs.add(joueur);
		
		this.vueEditerEquipe.afficherListeJoueurs(listeJoueurs);
	}
	
	public void notifierEnregistrerEquipe() {
		System.out.println("ControleurEquipe.notifierEnregistreEquipe()");
		Equipe equipe = this.navigateur.getVueEditerEquipe().demanderEquipe();
		this.equipeDAO.modifierEquipe(equipe);
		this.vueListeEquipe.afficherListeEquipe(this.equipeDAO.listerEquipes());
		this.navigateur.naviguerVersVueListeEquipe();
	}
	
	public void notifierEnregistrerNouvelleEquipe() {
		Equipe equipe = this.navigateur.getVueAjouterEquipe().demanderEquipe();
		this.equipeDAO.ajouterEquipe(equipe);
		this.vueListeEquipe.afficherListeEquipe(this.equipeDAO.listerEquipes());
		this.navigateur.naviguerVersVueListeEquipe();
	}
	
	public void notifierNaviguerAjouterEquipe()
	{
		System.out.println("ControleurEquipe.notifierNaviguerAjouterEquipe()");
		this.navigateur.naviguerVersVueAjouterEquipe();
	}
	
	public void notifierNaviguerEditerEquipe(int idEquipe)
	{
		this.vueEditerEquipe.afficherEquipe(this.equipeDAO.rapporterEquipe(idEquipe));
		this.navigateur.naviguerVersVueEditerEquipe();
	}
}