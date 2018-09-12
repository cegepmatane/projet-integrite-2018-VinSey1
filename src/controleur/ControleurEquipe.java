package controleur;

import vue.NavigateurDesVues;

public class ControleurEquipe {
	
	private NavigateurDesVues navigateur;
	
	public ControleurEquipe(NavigateurDesVues navigateur)
	{
		this.navigateur = navigateur;
		System.out.println("Initialisation du controleur");
		
		this.navigateur.naviguerVersVueAjouterEquipe();
		this.navigateur.naviguerVersVueEquipe();
		this.navigateur.naviguerVersVueListeEquipe();
	}
}