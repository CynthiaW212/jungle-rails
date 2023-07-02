
describe('User Login', () => {
  beforeEach(() => {
    cy.visit('/login');
  });

  it('should log in the user successfully', () => {
    //Fill out the login form with correct user
    cy.get('input[name="user[email]"]').type('tester@gmail.com');
    cy.get('input[name="user[password]"]').type('cypress');

    // Submit the form
    cy.get('input[type="submit"]').click();
    cy.get('nav').should('contain', 'Logout');
    cy.get(".products article").should("have.length", 2);
  });

  it('should handle invalid login credentials', () => {
    // Fill out the login form with invalid credentials
    cy.get('input[name="user[email]"]').type('tester@gmail.com');
    cy.get('input[name="user[password]"]').type('wrongpw');
    // Submit the form
    cy.get('input[type="submit"]').click();
    // Assert that user is not logged in
    cy.get('nav').should('contain', 'Login');
    cy.get('.btn').should('contain', 'Login');
  });

  it('should handle the signup and login sequence', () => {
    // Perform the signup process 
    cy.visit('/signup');
    cy.get('input[name="user[name]"]').type('NewOne');
    cy.get('input[name="user[email]"]').type('newone@gmail.com');
    cy.get('input[name="user[password]"]').type('newpassword');
    cy.get('input[name="user[password_confirmation]"]').type('newpassword');
    // Submit the form
    cy.get('input[type="submit"]').click();
    // Assert that the user is signed up successfully (e.g., check for logout button or user name)
    cy.get('nav').should('contain', 'Logout');
    cy.get('nav').should('contain','NewOne');

    // Log out the user
    cy.get('nav').contains('Logout').click();
    cy.get('nav').should('contain', 'Login');
    cy.contains('Logout successfully').should('be.visible');

  });

});