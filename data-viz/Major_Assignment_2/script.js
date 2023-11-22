const window_dims = {
    width: window.innerWidth,
    height: window.innerHeight
};

const svgWidth = window_dims.width / 2;
const svgHeight = window_dims.width / 3;

const MA_counties = "Data/towns.topojson"
const gini_index = "Data/gini_index.csv"
const CountiesData = "Data/counties.topojson"


Promise.all([
    d3.json(MA_counties),
    d3.csv(gini_index),
]).then(data => {
    // topology data
    const topology_data = data[0];
    // gini index data
    const csv_data = data[1];

    const generateMap1 = (topo_data, containerName, width, height, margin = 30) => {
        const svg = d3.select(containerName)
            .append("svg")
            .attr("width", width)
            .attr("height", height);


        // if topojson file is imported we need to convert topology data to geojson
        const geojson = topojson.feature(topo_data, topo_data.objects.ma);

        //Projections
        const projections = [
            d3.geoAzimuthalEqualArea(), //Azimuthal projections project the sphere directly onto a plane.
            d3.geoAlbersUsa(), // USA conic projection
            d3.geoAlbers(), // equal-area conic projection
            d3.geoMercator(), // cylindrical projection
            d3.geoNaturalEarth1(), // pseudocylindrical projection designed by Tom Patterson
            d3.geoEqualEarth(), // Equal Earth projection, by Bojan Šavrič et al., 2018.
            d3.geoConicEqualArea(), //equal-area conic projection
            d3.geoEquirectangular(), //Cylindrical Projections
            d3.geoOrthographic()
        ]

        //GeoPAthGenerator
        const geoPath_generator = d3.geoPath()
            .projection(projections[3].fitSize([width - margin, height - margin], geojson))

        const colorInterpolator = d3.interpolateRgbBasis(['#d73027', '#fc8d59', '#fee090', '#e0f3f8', '#91bfdb', '#4575b4'].reverse())

        const linearScale = d3.scaleLinear()
            .domain(d3.extent(geojson.features, (d) => {
                return d['properties']['POP1980']
            }))

        const tooltip = d3.select("#tooltip");

        svg.selectAll("path")
            .data(geojson.features)
            .enter()
            .append("path")
            .attr("d", d => geoPath_generator(d))
            .attr("fill", d => colorInterpolator(linearScale(d['properties']['POP1980'])))
            .on("mouseenter", (m, d) => {
                tooltip.transition()
                    .duration(200)
                    .style("opacity", .9)
                tooltip.html(d['properties']['POP1980'])
                    .style("left", m.clientX + "px")
                    .style("top", m.clientY + "px");
            })
            .on("mousemove", (m, d) => {
                tooltip.style("opacity", .9)
            })
            .on("mouseout", (m, d) => {
                tooltip.transition()
                    .duration(400)
                    .style("opacity", 0)
            })
    }

    const generateMap2 = (topo_data, containerName, width, height, margin = 30) => {
        const svg = d3.select(containerName).append("svg")
            .attr("width", width)
            .attr("height", height);

        // if topojson file is imported we need to
        // convert topology data to geojson
        const geojson = topojson.feature(topo_data, topo_data.objects.ma);


        const projections = [
            d3.geoAzimuthalEqualArea(), //Azimuthal projections project the sphere directly onto a plane.
            d3.geoAlbersUsa(), // USA conic projection
            d3.geoAlbers(), // equal-area conic projection
            d3.geoMercator(), // cylindrical projection
            d3.geoNaturalEarth1(), // pseudocylindrical projection designed by Tom Patterson
            d3.geoEqualEarth(), // Equal Earth projection, by Bojan Šavrič et al., 2018.
            d3.geoConicEqualArea(), //equal-area conic projection
            d3.geoEquirectangular(), //Cylindrical Projections
            d3.geoOrthographic()
        ]


        const geoPath_generator = d3.geoPath()
            .projection(projections[3].fitSize([width - margin, height - margin], geojson))

        const colorInterpolator = d3.interpolateRgbBasis(['#d73027', '#fc8d59', '#fee090', '#e0f3f8', '#91bfdb', '#4575b4'].reverse())

        const linearScale = d3.scaleLinear()
            .domain(d3.extent(geojson.features, (d) => {
                return d['properties']['POPCH00_10']
            }))

        const tooltip = d3.select("#tooltip");

        svg.selectAll("path")
            .data(geojson.features)
            .enter()
            .append("path")
            .attr("d", d => geoPath_generator(d))
            //.attr("fill", d => colorInterpolator(logScale(d['properties']['POP2010'])))
            .attr("fill", d => colorInterpolator(linearScale(d['properties']['POPCH00_10'])))
            .on("mouseenter", (m, d) => {
                tooltip.transition()
                    .duration(200)
                    .style("opacity", .9)
                tooltip.html(`PopulationChange:${d['properties']['POPCH00_10']} <br> Town:${d['properties']['TOWN']}`)
                    .style("left", m.clientX + "px")
                    .style("top", m.clientY + 350 + "px");
            })
            .on("mousemove", (m, d) => {
                tooltip.style("opacity", .9)
            })
            .on("mouseout", (m, d) => {
                tooltip.transition()
                    .duration(400)
                    .style("opacity", 0)
            })
    }

    const generateMap3 = (topo_data, containerName, width, height, margin = 30) => {
        const svg = d3.select(containerName).append("svg")
            .attr("width", width)
            .attr("height", height);


        const geojson = topojson.feature(topo_data, topo_data.objects.ma);


        const projections = [
            d3.geoAzimuthalEqualArea(), //Azimuthal projections project the sphere directly onto a plane.
            d3.geoAlbersUsa(), // USA conic projection
            d3.geoAlbers(), // equal-area conic projection
            d3.geoMercator(), // cylindrical projection
            d3.geoNaturalEarth1(), // pseudocylindrical projection designed by Tom Patterson
            d3.geoEqualEarth(), // Equal Earth projection, by Bojan Šavrič et al., 2018.
            d3.geoConicEqualArea(), //equal-area conic projection
            d3.geoEquirectangular(), //Cylindrical Projections
            d3.geoOrthographic()
        ]


        const geoPath_generator = d3.geoPath()
            .projection(projections[3].fitSize([width - margin, height - margin], geojson))

        const tooltip = d3.select("#tooltip");

        const County = [{ "county": "Barnstable County", "fips_code": 25001 }, { "county": "Berkshire County", "fips_code": 25003 }, { "county": "Bristol County", "fips_code": 25005 }, { "county": "Dukes County", "fips_code": 25007 }, { "county": "Essex County", "fips_code": 25009 }, { "county": "Franklin County", "fips_code": 25011 }, { "county": "Hampden County", "fips_code": 25013 }, { "county": "Hampshire County", "fips_code": 25015 }, { "county": "Middlesex County", "fips_code": 25017 }, { "county": "Nantucket County", "fips_code": 25019 }, { "county": "Norfolk County", "fips_code": 25021 }, { "county": "Plymouth County", "fips_code": 25023 }, { "county": "Suffolk County", "fips_code": 25025 }, { "county": "Worcester County", "fips_code": 25027 }]
        const FIPSToCounty = {};

        County.forEach(entry => {
            FIPSToCounty[entry.fips_code] = entry.county;
        });
        const dat1 = Object.values(County.map(d => d.fips_code));

        // Define a color scale using D3's ordinal scale
        const colorScale = d3.scaleOrdinal()
            //.domain(County.map(d => d.county))
            .domain(dat1)
            .range(d3.schemeCategory10); // You can replace these colors with your own choices


        svg.selectAll("path")
            .data(geojson.features)
            .enter()
            .append("path")
            .attr("d", d => geoPath_generator(d))

            .attr("fill", d => {
                const town = d['properties']['FIPS_STCO']; // Assuming 'TOWN' is the town name property
                //const county2 = County.map(d => d.county); // Assuming townToCounty is a lookup table
                const county2 = FIPSToCounty[town];
                console.log(county2)
                //console.log(town)
                return colorScale(county2);
            })
            .on("mouseenter", (m, d) => {
                const town = d['properties']['FIPS_STCO'];
                const county2 = FIPSToCounty[town];
                tooltip.transition()
                    .duration(200)
                    .style("opacity", .9)
                tooltip.html(`<div>
                        County: ${county2}<br>
                        Town: ${d['properties']['TOWN']}<br>
                        FIPS_Code: ${d['properties']['FIPS_STCO']}<br>
                        Population in 1980: ${d['properties']['POP1980']}<br>
                        Population in 1990: ${d['properties']['POP1990']}<br>
                        Population in 2000: ${d['properties']['POP2000']}<br>
                        Population Change Between 1980 and 1990: ${d['properties']['POPCH80_90']}<br>
                        Population Change Between 1990 and 2000: ${d['properties']['POPCH90_00']}<br>
                        Population in 2010: ${d['properties']['POP2010']}<br>
                        Population Change Between 2000 and 2010: ${d['properties']['POPCH00_10']}<br>
                        </div>`)
                    .style("left", m.clientX + "px")
                    .style("top", m.clientY + 900 + "px");
            })
            .on("mousemove", (m, d) => {
                tooltip.style("opacity", .9)
            })
            .on("mouseout", (m, d) => {
                tooltip.transition()
                    .duration(400)
                    .style("opacity", 0)
            })

    }

    const generateByGiniIndex = (topo_data, csv_data, containerName, width, height, margin = 30) => {
        const svg = d3.select(containerName).append("svg")
            .attr("width", width)
            .attr("height", height);


        // if topojson file is imported we need to
        // convert topology data to geojson
        const geojson = topojson.feature(topo_data, topo_data.objects.ma);


        const projections = [
            d3.geoAzimuthalEqualArea(), //Azimuthal projections project the sphere directly onto a plane.
            d3.geoAlbersUsa(), // USA conic projection
            d3.geoAlbers(), // equal-area conic projection
            d3.geoMercator(), // cylindrical projection
            d3.geoNaturalEarth1(), // pseudocylindrical projection designed by Tom Patterson
            d3.geoEqualEarth(), // Equal Earth projection, by Bojan Šavrič et al., 2018.
            d3.geoConicEqualArea(), //equal-area conic projection
            d3.geoEquirectangular(), //Cylindrical Projections
            d3.geoOrthographic()
        ]

        const geoPath_generator = d3.geoPath()
            .projection(projections[3].fitSize([width - margin, height - margin], geojson))


        const tooltip = d3.select("#tooltip");

        const County = [{ "county": "Barnstable County", "fips_code": 25001 }, {
            "county": "Berkshire County",
            "fips_code": 25003
        },
        { "county": "Bristol County", "fips_code": 25005 }, {
            "county": "Dukes County",
            "fips_code": 25007
        },
        { "county": "Essex County", "fips_code": 25009 }, {
            "county": "Franklin County",
            "fips_code": 25011
        },
        { "county": "Hampden County", "fips_code": 25013 }, {
            "county": "Hampshire County",
            "fips_code": 25015
        },
        { "county": "Middlesex County", "fips_code": 25017 }, {
            "county": "Nantucket County",
            "fips_code": 25019
        },
        { "county": "Norfolk County", "fips_code": 25021 }, {
            "county": "Plymouth County",
            "fips_code": 25023
        },
        { "county": "Suffolk County", "fips_code": 25025 }, { "county": "Worcester County", "fips_code": 25027 }]
        const FIPSToCounty = {};

        County.forEach(entry => {
            FIPSToCounty[entry.fips_code] = entry.county;
        });

        d3.csv(gini_index).then(data => {
            data = data.filter(d => d.year == 2017);
            const giniByCounty = {};
            data.forEach(d => {
                const countyID = d.id.slice(-5);
                const giniIndex = +d['Estimate!!Gini Index'];
                giniByCounty[countyID] = giniIndex;
            });
            console.log(giniByCounty)
            // Define a color scale based on Gini index
            const giniExtent = d3.extent(Object.values(giniByCounty));
            const colorScale = d3.scaleSequential(d3.interpolateBlues)
                .domain(giniExtent);

            svg.selectAll("path")
                .data(geojson.features)
                .enter()
                .append("path")
                .attr("d", d => geoPath_generator(d))
                .attr("fill", d => {
                    const countyID = d['properties']['FIPS_STCO'];
                    console.log(countyID)
                    const giniIndex = giniByCounty[countyID];
                    return colorScale(giniIndex);
                })

                .on("mouseenter", (m, d) => {
                    const countyID = d['properties']['FIPS_STCO'];
                    const giniIndex = giniByCounty[countyID];
                    tooltip.transition()
                        .duration(200)
                        .style("opacity", .9)
                    tooltip.html(`<div>
                            County ID: ${countyID}<br>
                            Gini Index 2019: ${giniIndex}<br>
                            </div>`)
                        .style("left", m.clientX + "px")
                        .style("top", m.clientY + "px");
                })
                .on("mousemove", (m, d) => {
                    tooltip.style("opacity", .9)
                })
                .on("mouseout", (m, d) => {
                    tooltip.transition()
                        .duration(400)
                        .style("opacity", 0)
                })
        })
    }

    generateMap1(topology_data, ".fig1", svgWidth, svgHeight)
    generateMap2(topology_data, ".fig2", svgWidth, svgHeight)
    generateMap3(topology_data, ".fig3", svgWidth, svgHeight)
    generateByGiniIndex(topology_data, csv_data, ".fig4", svgWidth, svgHeight)
})
