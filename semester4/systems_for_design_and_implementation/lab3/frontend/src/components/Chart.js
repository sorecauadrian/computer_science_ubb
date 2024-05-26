import { useState } from "react";
import { IoStatsChartOutline } from "react-icons/io5";
import { Button, Modal } from "react-bootstrap";
import { Bar } from "react-chartjs-2";
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

function BarChart({products})
{
    const [show, setShow] = useState(false);
    const [priceData, setPriceData] = useState({});

    const handleClose = () => setShow(false);
    const handleShow = () => 
    {
        setShow(true)
        generatePriceData();
    };

    const generatePriceData = () => {
        const priceCounts = {};
        products.forEach((product) => {priceCounts[product.price] = (priceCounts[product.price] || 0) + 1;});

        const labels = Object.keys(priceCounts);
        labels.sort(function (price1, price2) {return price1 - price2;});
        const data = labels.map((label) => priceCounts[label]);

        setPriceData({
            labels: labels,
            datasets: [
                {
                    label: "price",
                    backgroundColor: "rgba(75, 192, 192, 1)",
                    borderColor: "rgba(0, 0, 0, 1)",
                    borderWidth: 1,
                    data: data
                }
            ]
        });
    };

    return (
        <>
            <div className="d-grid gap-2">
                <Button variant="primary" onClick={handleShow} data-testid="chart">
                    <IoStatsChartOutline />
                </Button>
            </div>
            
            <Modal show={show} onHide={handleClose} animation={false}>
                <Modal.Header closeButton>
                    <Modal.Title>
                        price chart
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    {Object.keys(priceData).length > 0 && (
                        <Bar
                            data={priceData}
                            options={{
                                title: {
                                    display: true,
                                    text: "price distribution",
                                    fontSize: 20
                                },
                                legend: {
                                    display: true,
                                    position: "right"
                                }
                            }}
                            data-testid="barchart"
                        />
                    )}
                </Modal.Body>
            </Modal>
        </>
    );
}

export default BarChart;