package action;

import donnee.EquipeDAO;
import donnee.JoueurDAO;
import modele.Equipe;
import modele.Joueur;
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
	private EquipeDAO equipeDAO = null;
	private ControleurEquipe controleurEquipe = null;
	
	public static ControleurJoueur getInstance(ControleurEquipe controleurEquipe)
	{
		if(null == instance) instance = new ControleurJoueur(controleurEquipe);
		return instance;
	}
	
	private ControleurJoueur(ControleurEquipe controleurEquipe) {
		this.controleurEquipe = controleurEquipe;
		this.joueurDAO = controleurEquipe.getJoueurDAO();
		this.equipeDAO = controleurEquipe.getEquipeDAO();
	}
	
	public void activerVues(NavigateurDesVues navigateur)
	{
		this.navigateur = navigateur;
		this.vueAjouterJoueur = navigateur.getVueAjouterJoueur();
		this.vueEditerJoueur = navigateur.getVueEditerJoueur();
	}
	
	public void notifierEnregistrerJoueur() {
		System.out.println("ControleurJoueur.notifierEnregistrerJoueur()");
		Joueur joueur = this.navigateur.getVueEditerJoueur().demanderJoueur();
		this.joueurDAO.modifierJoueur(joueur);
		this.controleurEquipe.getVueEditerEquipe().afficherListeJoueurs(this.joueurDAO.listerJoueurs(this.navigateur.getVueEditerEquipe().getIdEquipe()));
		this.navigateur.naviguerVersVueEditerEquipe();
	}
	
	public void notifierEnregistrerNouveauJoueur() {
		System.out.println("ControleurJoueur.notifierEnregistrerNouveauJoueur()");
		Joueur joueur = this.navigateur.getVueAjouterJoueur().demanderJoueur();
		this.joueurDAO.ajouterJoueur(joueur, this.navigateur.getVueEditerEquipe().getIdEquipe());
		this.controleurEquipe.getVueEditerEquipe().afficherListeJoueurs(this.joueurDAO.listerJoueurs(this.navigateur.getVueEditerEquipe().getIdEquipe()));
		this.navigateur.naviguerVersVueEditerEquipe();
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

	public void notifierSupprimerJoueur(int idJoueur) {
		System.out.println("ControleurJoueur.notifierSupprimerJoueur");
		System.out.println("Suppression du joueur "+this.joueurDAO.rapporterJoueur(idJoueur).getNom());
	}
}
