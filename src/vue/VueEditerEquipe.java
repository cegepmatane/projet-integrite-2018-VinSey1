package vue;

import java.util.ArrayList;
import java.util.List;

import action.ControleurEquipe;
import action.ControleurJoueur;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import modele.Equipe;
import modele.Joueur;

public class VueEditerEquipe  extends Scene {
	
	protected TextField valeurNom;
	protected TextField valeurAnnee;
	protected TextField valeurRegion;
	
	private ControleurEquipe controleurEquipe = null;
	private ControleurJoueur controleurJoueur = null;
	protected Button actionEnregistrerEquipe = null;
	private GridPane grilleListeJoueurs = new GridPane();
	
	private int idEquipe = 0;
	
	public VueEditerEquipe() {
		
		super(new VBox(), 400, 400);
		VBox panneau = (VBox) this.getRoot();
		GridPane grilleEquipes = new GridPane();
		this.actionEnregistrerEquipe = new Button("Enregistrer");
		
		this.actionEnregistrerEquipe.setOnAction(new EventHandler<ActionEvent>() {
 			@Override
			public void handle(ActionEvent arg0) {
				
				controleurEquipe.notifierEnregistrerEquipe();
				
			}});
		
		valeurNom = new TextField();
		grilleEquipes.add(new Label("Nom : "), 0, 0);
		grilleEquipes.add(valeurNom, 1, 0);
		
		valeurAnnee = new TextField("");
		grilleEquipes.add(new Label("Année de création : "), 0, 1);
		grilleEquipes.add(valeurAnnee, 1, 1);
		
 		valeurRegion = new TextField("");
		grilleEquipes.add(new Label("Région : "), 0, 2);
		grilleEquipes.add(valeurRegion, 1, 2);		
			
		panneau.getChildren().add(new Label("Editer une équipe"));
		panneau.getChildren().add(grilleEquipes);
		panneau.getChildren().add(new Label("Joueurs :"));
		panneau.getChildren().add(grilleListeJoueurs);
		panneau.getChildren().add(this.actionEnregistrerEquipe);
		
	}
	
	public void afficherListeJoueurs(List<Joueur> listeJoueurs){
		int iterateur = 0;
		for(Joueur joueurActuel : listeJoueurs) {
			Button actionEditerJoueur = new Button("Éditer");
			
			actionEditerJoueur.setOnAction(new EventHandler<ActionEvent>() {
	 			@Override
				public void handle(ActionEvent arg0) {
					
					controleurJoueur.notifierNaviguerEditerJoueur(joueurActuel.getId());
					
				}});
			this.grilleListeJoueurs.add(new Label(joueurActuel.getNom()+""), 0 ,iterateur);
			this.grilleListeJoueurs.add(new Label(joueurActuel.getNaissance()+""), 1 ,iterateur);
			this.grilleListeJoueurs.add(new Label(joueurActuel.getNationalite()+""),2 ,iterateur);
			this.grilleListeJoueurs.add(actionEditerJoueur, 3, iterateur);
			this.grilleListeJoueurs.add(new Button("Effacer"), 4, iterateur);
			iterateur++;
		}
		Button actionAjouterJoueur = new Button("Ajouter Joueur");
		actionAjouterJoueur.setOnAction(new EventHandler<ActionEvent>() {
 			@Override
			public void handle(ActionEvent arg0) {
				
				controleurJoueur.notifierNaviguerAjouterJoueur();
				
			}});
		
		this.grilleListeJoueurs.add(actionAjouterJoueur, 0, iterateur+1);
		
	}
	
	public Equipe demanderEquipe()
	{
		Equipe equipe = new Equipe(this.valeurNom.getText(), this.valeurAnnee.getText(), this.valeurRegion.getText());
		equipe.setId(idEquipe);
		return equipe;
	}
	
	public void setControleurEquipe(ControleurEquipe controleur) {
		this.controleurEquipe = controleur;
	}
	
	public void setControleurJoueur(ControleurJoueur controleurJoueur) {
		this.controleurJoueur = controleurJoueur;
	}
	
	public void afficherEquipe(Equipe equipe) {
		this.idEquipe = equipe.getId();
		this.valeurNom.setText(equipe.getNom());
		this.valeurAnnee.setText(equipe.getAnneeDeCreation());
		this.valeurRegion.setText(equipe.getRegion());
	}
	
 }