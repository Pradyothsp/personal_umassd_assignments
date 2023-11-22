function createLineChart(data) {
    // Set up the SVG dimensions and margins
    const width = 1000;
    const height = 800;
    const margin = {
        top: 50,
        right: 50,
        bottom: 50,
        left: 50
    };

    const rawMaterial_min_max = d3.extent(data, (d) => d.RawMaterial);
    const workmanship_min_max = d3.extent(data, (d) => d.Workmanship);
    const yearlyStorage_min_max = d3.extent(data, (d) => d.YearlyStorage);
    const y_min_max = d3.extent(
        [
            rawMaterial_min_max[0],
            rawMaterial_min_max[1],
            workmanship_min_max[0],
            workmanship_min_max[1],
            yearlyStorage_min_max[0],
            yearlyStorage_min_max[1],
        ],
        (d) => d
    );

    // Create the SVG container
    const svg = d3.select("#chart")
        .attr("width", width)
        .attr("height", height);

    // Create scales for x and y axes
    const xScale = d3.scaleTime()
        .domain(d3.extent(data, d => d.Date))
        .range([margin.left, width - margin.right]);

    const yScale = d3.scaleLinear()
        .domain(y_min_max)
        .nice()
        .range([height - margin.bottom, margin.top]);

    // Create axes
    const xAxis = d3.axisBottom(xScale);
    const yAxis = d3.axisLeft(yScale);

    svg.append("g")
        .attr("class", "x-axis")
        .attr("transform", `translate(0, ${height - margin.bottom})`)
        .call(xAxis);

    svg.append("g")
        .attr("class", "y-axis")
        .attr("transform", `translate(${margin.left}, 0)`)
        .call(yAxis);

    // Create line generators for each dataset
    const tension = 0.5; // Adjust the tension value (between 0 and 1) as needed

    const lineRawMaterial = d3.line()
        .x(d => xScale(d.Date))
        .y(d => yScale(d.RawMaterial))
        .curve(d3.curveCardinal.tension(tension));

    const lineWorkmanship = d3.line()
        .x(d => xScale(d.Date))
        .y(d => yScale(d.Workmanship))
        .curve(d3.curveCardinal.tension(tension));

    const lineYearlyStorage = d3.line()
        .x(d => xScale(d.Date))
        .y(d => yScale(d.YearlyStorage))
        .curve(d3.curveCardinal.tension(tension));

    // Draw lines for each dataset
    const keys = ['RawMaterial', 'Workmanship', 'YearlyStorage'];
    const color = d3.scaleOrdinal(d3.schemeCategory10);

    svg.append("path")
        .datum(data)
        .attr("class", "line")
        .attr("d", lineRawMaterial)
        .style("stroke", color('RawMaterial')); // Set the stroke color for this line

    svg.append("path")
        .datum(data)
        .attr("class", "line")
        .attr("d", lineWorkmanship)
        .style("stroke", color('Workmanship')); // Set the stroke color for this line

    svg.append("path")
        .datum(data)
        .attr("class", "line")
        .attr("d", lineYearlyStorage)
        .style("stroke", color('YearlyStorage')); // Set the stroke color for this line

    // Adding legend
    const legendRectSize = 10;
    const legendSpacing = 15;

    const legend = svg.selectAll('.legend')
        .data(keys)
        .enter()
        .append('g')
        .attr('class', 'legend')
        .attr('transform', function (d, i) {
            const legendHeight = legendRectSize + legendSpacing;
            const offset = legendHeight * keys.length / 2;
            const horz = 600;
            const vert = i * legendHeight + 50 - offset;
            return 'translate(' + horz + ',' + vert + ')';
        });

    legend.append('rect')
        .attr('width', legendRectSize)
        .attr('height', legendRectSize)
        .style('fill', color);

    legend.append('text')
        .attr('x', legendRectSize + 6)
        .attr('y', legendRectSize - 6)
        .text(function (d) {
            return d;
        });

    // Add x-axis label
    svg.append("text")
        .attr("class", "x-axis-label")
        .attr("x", width / 2)
        .attr("y", height - 10) // Adjust the position as needed
        .style("text-anchor", "middle")
        .text("Date");

    // Add y-axis label
    svg.append("text")
        .attr("class", "y-axis-label")
        .attr("x", -(height / 2))
        .attr("y", margin.left / 2) // Adjust the position as needed
        .attr("transform", "rotate(-90)")
        .style("text-anchor", "middle")
        .text("Value");


    // Add legends, transitions, and additional styling (you'll need to implement this separately)
}

d3.csv("DataSample.csv").then(function (data) {
    // Convert data types and parse dates
    data.forEach(function (d) {
        d.Date = new Date(d.date);
        d.EstimatedCost = parseFloat(d.EstimatedCost);
        d.RawMaterial = parseFloat(d.RawMaterial);
        d.Workmanship = parseFloat(d.Workmanship);
        d.YearlyStorage = parseFloat(d.YearlyStorage);
    });

    // Call the function to create the line chart
    createLineChart(data);

}).catch(function (error) {
    // Handle any errors that occur during CSV loading
    console.error('Error reading CSV:', error);
});
