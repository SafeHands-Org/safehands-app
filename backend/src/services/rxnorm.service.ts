import axios from "axios";

const RXNORM_BASE_URL = "https://rxnav.nlm.nih.gov/REST";

export const searchMedications = async (name: string) => {
  const response = await axios.get(
    `${RXNORM_BASE_URL}/approximateTerm.json`,
    {
      params: {
        term: name,
        maxEntries: 10
      }
    }
  );

  return response.data.approximateGroup?.candidate || [];
};

export const getMedicationDetails = async (rxcui: string) => {
  const response = await axios.get(
    `${RXNORM_BASE_URL}/rxcui/${rxcui}/properties.json`
  );

  return response.data.properties;
};