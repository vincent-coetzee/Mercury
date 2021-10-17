//
//  PickerViewController.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

class CountryPickerViewController: UIViewController
    {
    @IBOutlet var countryPicker: UIPickerView!
    @IBOutlet var buttonView: UIButton!
    
    private var countriesViewModel: CountriesViewModel!
    private var countrySelectionButtonViewModel: CountrySelectionButtonViewModel!
    private var selectedCountry: Country?
    
    internal var countryModel: CountryModel!
        {
        didSet
            {
            self.initViewModels()
            self.initViews()
            }
        }
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        if let sheetController = self.presentationController as? UISheetPresentationController
            {
            sheetController.detents = [.medium()]
            sheetController.prefersGrabberVisible = false
            sheetController.preferredCornerRadius = 20
            }
        }
        
    private func initViews()
        {
        self.countryPicker.delegate = self
        var row = 0
        let code = self.countryModel.country!.code
        let countries = self.countryModel.countries
        for index in 0..<countries.count
            {
            if countries[index].code == code
                {
                row = index
                break
                }
            }
        self.countryPicker.selectRow(row, inComponent: 0, animated: true)
        }
        
    private func initViewModels()
        {
        self.countriesViewModel = CountriesViewModel(countryModel: countryModel)
        self.countriesViewModel.configure(view: self.countryPicker)
        self.countrySelectionButtonViewModel = CountrySelectionButtonViewModel()
        self.countrySelectionButtonViewModel.country = self.countryModel.country!
        self.countrySelectionButtonViewModel.configure(button: self.buttonView)
        }
        
    @IBAction func onButtonTapped(_ sender: Any?)
        {
        if let country = self.selectedCountry
            {
            self.countryModel.setCountry(country)
            self.dismiss(animated: true)
            }
        }
    }

extension CountryPickerViewController: UIPickerViewDelegate
    {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
        return(self.countriesViewModel.countries[row].name)
        }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
        let selectedCountry = self.countryModel.countries[row]
        self.countrySelectionButtonViewModel.country = selectedCountry
        self.countrySelectionButtonViewModel.configure(button: self.buttonView)
        self.selectedCountry = selectedCountry
        }
    }
