package vue;

import action.ControleurEquipe;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import modele.Equipe;

public class VueEditerEquipe  extends Scene {
	
	protected TextField valeurNom;
	protected TextField valeurAnnee;
	protected TextField valeurRegion;
	
	private ControleurEquipe controleurEquipe = null;
	protected Button actionEnregistrerEquipe = null;
	
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
		grilleEquipes.add(new Label("Ann�e de cr�ation : "), 0, 1);
		grilleEquipes.add(valeurAnnee, 1, 1);
		
 		valeurRegion = new TextField("");
		grilleEquipes.add(new Label("R�gion : "), 0, 2);
		grilleEquipes.add(valeurRegion, 1, 2);					
			
		panneau.getChildren().add(new Label("Editer une �quipe"));
		panneau.getChildren().add(grilleEquipes);
		panneau.getChildren().add(this.actionEnregistrerEquipe);
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
	
	public void afficherEquipe(Equipe equipe) {
		this.idEquipe = equipe.getId();
		this.valeurNom.setText(equipe.getNom());
		this.valeurAnnee.setText(equipe.getAnneeDeCreation());
		this.valeurRegion.setText(equipe.getRegion());
	}
	
 }