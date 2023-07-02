describe('jungle product details page', () => {
  // beforeEach(() => {
  //   cy.visit('/')
  // })

  it('should visit the home page', () => {
    cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('should navigate from home page to product detail page', () => {
    cy.get('.products').children().first().click(); 

    // Assert that the product detail page is loaded
    cy.url().should('include', '/products/');
  
    cy.contains('Add');

  });


})