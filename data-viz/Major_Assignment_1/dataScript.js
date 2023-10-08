const loadData = d3.csv("DataSample.csv", function (data) {
    return {
        date: new Date(data.date),
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


// Function to format the date to "mm-dd-yyyy" format
function formatDateToMMDDYYYY(inputDate) {
    const year = inputDate.getFullYear();
    const month = (inputDate.getMonth() + 1).toString().padStart(2, '0'); // +1 because months are zero-indexed
    const day = inputDate.getDate().toString().padStart(2, '0');
    return `${month}-${day}-${year}`;
}


// Function to calculate and update the table
function calculateProfit(d) {
    const tableBody = document.getElementById("profitTableBody");
    tableBody.innerHTML = "";

    console.log("Calculating data for the table...")

    d.forEach(row => {
        // Create the formatted date string in "mm-dd-yyyy" format
        const formattedDate = formatDateToMMDDYYYY(row.date);

        const actualCost = (row.RawMaterial + row.Workmanship + (row.YearlyStorage/12)).toFixed(2);
        const soldPrice = (row.EstimatedCost * 1.1).toFixed(2);
        const marginOfProfit = (soldPrice - actualCost).toFixed(2);

        const newRow = document.createElement("tr");
        newRow.innerHTML = `
            <td>${formattedDate}</td>
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
