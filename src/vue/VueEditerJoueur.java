package vue;

import java.util.ArrayList;
import java.util.List;

import action.ControleurEquipe;
import action.ControleurJoueur;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import modele.Equipe;
import modele.Joueur;

public class VueEditerJoueur  extends Scene {
	
	protected TextField valeurNom;
	protected TextField valeurNaissance;
	protected TextField valeurNationalite;
	private Joueur joueur;
	
	private ControleurJoueur controleurJoueur = null;
	protected Button actionEnregistrerJoueur = null;
		
	public VueEditerJoueur() {
		
		super(new VBox(), 400, 400);
		VBox panneau = (VBox) this.getRoot();

		GridPane grilleJoueur = new GridPane();
		this.actionEnregistrerJoueur = new Button("Enregistrer");
		
		this.actionEnregistrerJoueur.setOnAction(new EventHandler<ActionEvent>() {
 			@Override
			public void handle(ActionEvent arg0) {
				
 				controleurJoueur.notifierEnregistrerJoueur();
				
			}});
		
		valeurNom = new TextField();
		grilleJoueur.add(new Label("Nom : "), 0, 0);
		grilleJoueur.add(valeurNom, 1, 0);
		
		valeurNaissance = new TextField();
		grilleJoueur.add(new Label("Naissance : "), 0, 1);
		grilleJoueur.add(valeurNaissance, 1, 1);
		
		valeurNationalite = new TextField();
		grilleJoueur.add(new Label("Région : "), 0, 2);
		grilleJoueur.add(valeurNationalite, 1, 2);	
			
		panneau.getChildren().add(new Label("Editer un joueur"));
		panneau.getChildren().add(grilleJoueur);
		panneau.getChildren().add(this.actionEnregistrerJoueur);
	}
	
	public Joueur demanderJoueur()
	{
		this.joueur.setNaissance(this.valeurNaissance.getText());
		this.joueur.setNom(this.valeurNom.getText());
		this.joueur.setNationalite(this.valeurNationalite.getText());
		return joueur;
	}
	
	public void setControleurJoueur(ControleurJoueur controleur) {
		this.controleurJoueur = controleur;
	}
	
	public void afficherJoueur(Joueur joueur) {
		this.joueur = joueur;
		this.valeurNom.setText(joueur.getNom());
		this.valeurNaissance.setText(joueur.getNaissance());
		this.valeurNationalite.setText(joueur.getNationalite());
	}
	
 }