const loadData = d3.csv("DataSample.csv", function (data) {
    return {
        date: data.date,
        EstimatedCost: parseFloat(data.EstimatedCost),
        RawMaterial: parseFloat(data.RawMaterial),
        Workmanship: parseFloat(data.Workmanship),
        YearlyStorage: parseFloat(data.YearlyStorage)
    }

}).then(function (data) {
    console.log("Data loaded successfully")
    // Call the function to populate the table with calculated values
    calculateProfit(data);

}).catch(function (error) {
    // Handle any errors that occur during CSV loading
    console.error('Error reading CSV:', error);
});


// Function to calculate and update the table
function calculateProfit(d) {
    const tableBody = document.getElementById("profitTableBody");
    tableBody.innerHTML = "";

    console.log("Calculating data for the table...")

    d.forEach(row => {
        const actualCost = (row.RawMaterial + row.Workmanship + row.YearlyStorage).toFixed(2);
        const soldPrice = (row.EstimatedCost * 1.1).toFixed(2);
        const marginOfProfit = (soldPrice - actualCost).toFixed(2);

        const newRow = document.createElement("tr");
        newRow.innerHTML = `
            <td>${row.date}</td>
            <td>${row.EstimatedCost}</td>
            <td>${row.RawMaterial}</td>
            <td>${row.Workmanship}</td>
            <td>${row.YearlyStorage}</td>
            <td>${actualCost}</td>
            <td>${soldPrice}</td>
            <td>${marginOfProfit}</td>
        `;
        tableBody.appendChild(newRow);
    });
    console.log("Data calculated successfully")
}
