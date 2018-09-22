package action;

import java.util.ArrayList;
import java.util.List;

import donnee.EquipeDAO;
import donnee.JoueurDAO;
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
	private JoueurDAO joueurDAO = null;
	
	
	public static ControleurEquipe getInstance()
	{
		if(null == instance) instance = new ControleurEquipe();
		return instance;
	}
	
	private ControleurEquipe() {
		System.out.println("Initialisation du contrôleur");
		this.equipeDAO = new EquipeDAO();
		this.joueurDAO = new JoueurDAO();
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
		

		
		//this.vueEditerEquipe.afficherListeJoueurs(joueurDAO.listerJoueurs());
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
		this.vueEditerEquipe.afficherListeJoueurs(this.joueurDAO.listerJoueurs(idEquipe));
	}
	
	public EquipeDAO getEquipeDAO() {
		return equipeDAO;
	}
	
	public JoueurDAO getJoueurDAO() {
		return joueurDAO;
	}
	
	public VueEditerEquipe getVueEditerEquipe() {
		return this.vueEditerEquipe;
	}
}