package action;

import donnee.EquipeDAO;
import donnee.JoueurDAO;
import modele.Equipe;
import vue.NavigateurDesVues;
import vue.VueAjouterEquipe;
import vue.VueAjouterJoueur;
import vue.VueEditerEquipe;
import vue.VueEditerJoueur;
import vue.VueEquipe;
import vue.VueListeEquipe;

public class ControleurJoueur {

	private static ControleurJoueur instance = null;

	private NavigateurDesVues navigateur;
	private VueAjouterJoueur vueAjouterJoueur = null;
	private VueEditerJoueur vueEditerJoueur = null;
	private JoueurDAO joueurDAO = null;
	
	public static ControleurJoueur getInstance()
	{
		if(null == instance) instance = new ControleurJoueur();
		return instance;
	}
	
	private ControleurJoueur() {
		this.joueurDAO = new JoueurDAO();
	}
	
	public void activerVues(NavigateurDesVues navigateur)
	{
		this.navigateur = navigateur;
		this.vueAjouterJoueur = navigateur.getVueAjouterJoueur();
		this.vueEditerJoueur = navigateur.getVueEditerJoueur();
	}
	
	public void notifierEnregistrerJoueur() {
		System.out.println("ControleurJoueur.notifierEnregistrerJoueur()");
		this.navigateur.naviguerVersVueListeEquipe();
	}
	
	public void notifierEnregistrerNouveauJoueur() {
		System.out.println("ControleurJoueur.notifierEnregistrerNouveauJoueur()");
		this.navigateur.naviguerVersVueListeEquipe();
	}
	
	public void notifierNaviguerAjouterJoueur()
	{
		System.out.println("ControleurJoueur.notifierNaviguerAjouterJoueur()");
		this.navigateur.naviguerVersVueAjouterJoueur();
	}
	
	public void notifierNaviguerEditerJoueur(int idJoueur)
	{
		System.out.println("ControleurJoueur.notifierNaviguerEditerJoueur");
		this.vueEditerJoueur.afficherJoueur(this.joueurDAO.rapporterJoueur(idJoueur));
		this.navigateur.naviguerVersVueEditerJoueur();
	}
}
