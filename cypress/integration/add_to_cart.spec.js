describe('jungle add product to cart', () => {

  it('should visit the home page', () => {
    cy.visit('/');
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('should click the add button to add the product to cart', () => {
    cy.get('.products').children().first().contains('Add');
    
  });

  it("should display 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('should click the add button to add the product to cart', () => {
    cy.get('.products').children().first().within(() => {
      cy.contains('Add').click({ force: true });
    });

    cy.get('nav').find('li.nav-item.end-0').contains('My Cart (1)');
  });

  it('should not add the product to cart if it sold out', () => {
    cy.get('.products').children().last().within(() => {
      cy.contains('sold out');
      cy.contains('Add').click({ force: true });
    });

    cy.get('nav').find('li.nav-item.end-0').contains('My Cart (1)');
  });


})