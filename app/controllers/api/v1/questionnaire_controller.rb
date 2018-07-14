class Api::V1::QuestionnaireController < Api::V1::ApiController

  def index
    logger.info '---------- index ---------------'
    logger.info params
    logger.info session[:response_id]

    # unless session[:response_id]
    #   @response = QuestionnaireResponse.create
    #   session[:response_id] = @response.id
    # else
    #   @response = QuestionnaireResponse.find(session[:response_id])
    # end

    if params[:scope] == 'all'
      logic = {
        "start_with": [1],
        "flow": {
          "1": {
            "go_to": [2]
          },
          "2": {
            "is_mandatory": true,
            "dependent_questions": [29, 30, 31, 32],
            "go_to": [3],
          },
          "3": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "<": [2, {
                  "var": "value"
                }, 66]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 3
            },
            "static_params": {
              "value_t": [6],
              "value_f": [4, 5]
            },
            "dependent_questions": [4, 5, 6],
            "save_checkpoint": true
          },
          "4": {},
          "5": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Edit"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 5
            },
            "static_params": {
              "value_t": [3],
              "value_f": [70]
            },
            "dependent_questions": [3, 70],
            "type": "edit"
          },
          "6": {
            "is_mandatory": true,
            "go_to": [7]
          },
          "7": {
            "is_mandatory": true,
            "go_to": [8]
          },
          "8": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "No"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 8
            },
            "static_params": {
              "value_t": [11],
              "value_f": [9, 10]
            },
            "dependent_questions": [11, 9, 10],
            "save_checkpoint": true
          },
          "9": {},
          "10": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Edit"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 10
            },
            "static_params": {
              "value_t": [8],
              "value_f": [70]
            },
            "dependent_questions": [8, 70],
            "type": "edit"
          },
          "11": {
            "go_to": [12]
          },
          "12": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "merge": [{
                "if": [{
                    "in": ["Face - forehead", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_face_forehead"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Face - cheek", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_face_cheek"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Face - jawline", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_face_jawline"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Scalp", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_scalp"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Chest", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_chest"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Back", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_back"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Shoulders", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_shoulders"
                  },
                  []
                ]
              }]
            },
            "dynamic_params": {
              "value": 12
            },
            "static_params": {
              "value_face_forehead": [13, 14, 15, 16, 17, 18],
              "value_face_cheek": [13, 14, 15, 16, 17, 18],
              "value_face_jawline": [13, 14, 15, 16, 17, 18],
              "value_scalp": [13, 14, 15, 16, 17, 18],
              "value_chest": [19],
              "value_back": [20],
              "value_shoulders": [21]
            },
            "has_sub_questions": true,
            "go_to": [22],
            "dependent_questions": [13, 14, 15, 16, 17, 18, 19, 20, 21],
            "save_checkpoint": true
          },
          "13": {},
          "14": {
            "save_checkpoint": true},
          "15": {},
          "16": {
            "save_checkpoint": true},
          "17": {},
          "18": {
            "save_checkpoint": true},
          "19": {},
          "20": {},
          "21": {},
          "22": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "merge": [{
                "if": [{
                    "in": ["Face wash", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_facewash"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Sunscreen", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_sunscreen"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Day cream", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_day_cream"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Night cream", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_night_cream"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Medicated cream", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_medicated_cream"
                  },
                  []
                ]
              }]
            },
            "dynamic_params": {
              "value": 22
            },
            "static_params": {
              "value_facewash": [23],
              "value_sunscreen": [24],
              "value_day_cream": [25],
              "value_night_cream": [26],
              "value_medicated_creams": [27],
            },
            "has_sub_questions": true,
            "go_to": [28],
            "dependent_questions": [23, 24, 25, 26, 27],
            "save_checkpoint": true
          },
          "23": {},
          "24": {},
          "25": {},
          "26": {},
          "27": {},
          "28": {
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Female"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 2
            },
            "static_params": {
              "value_t": [29],
              "value_f": [33]
            },
            "dependent_questions": [29, 33],
            "save_checkpoint": true
          },
          "29": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "merge": [{
                "if": [{
                    "in": ["Polycistic Ovarian Disease (PCOD)", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_pcod"
                  },
                  []
                ]
              }]
            },
            "dynamic_params": {
              "value": 6
            },
            "static_params": {
              "value_pcod": [30],
            },
            "has_sub_questions": true,
            "go_to": [32],
            "dependent_questions": [30]
          },
          "30": {
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Yes"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 30
            },
            "static_params": {
              "value_t": [31],
              "value_f": [32]
            },
            "dependent_questions": [31, 32]
          },
          "31": {
            "is_mandatory": true,
            "go_to": [32],
          },
          "32": {
            "is_mandatory": true,
            "go_to": [33],
          },
          "33": {
            "is_mandatory": true,
            "go_to": [34],
            "save_checkpoint": true
          },
          "34": {
            "is_mandatory": true,
            "go_to": [35],
          },
          "35": {
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Yes"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 35
            },
            "static_params": {
              "value_t": [36],
              "value_f": [37]
            },
            "dependent_questions": [36, 37]
          },
          "36": {
            "is_mandatory": true,
            "go_to": [37],
          },
          "37": {
            "is_mandatory": true,
            "requires_check": true,
            "jump_logic": {
              "merge": [{
                "if": [{
                    "in": ["Isotretinoin", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_isotretinoin"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Oral contraceptive pills", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_oral_contraceptive_pills"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Azithromycin / Roxithromycin", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_azithromycin_roxithromycin"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Minocycline / Doxycycline", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_minocycline_doxycycline"
                  },
                  []
                ]
              }, {
                "if": [{
                    "in": ["Oral steroids", {
                      "var": "value"
                    }]
                  }, {
                    "var": "value_oral_steroids"
                  },
                  []
                ]
              }]
            },
            "dynamic_params": {
              "value": 37
            },
            "static_params": {
              "value_isotretinoin": [38, 39, 40],
              "value_oral_contraceptive_pills": [41, 42, 43],
              "value_azithromycin_roxithromycin": [44, 45, 46],
              "value_minocycline_doxycycline": [47, 48, 49],
              "value_oral_steroids": [51, 52, 53],
            },
            "has_sub_questions": true,
            "go_to": [53],
            "dependent_questions": [38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52]
          },
          "38": {},
          "39": {},
          "40": {},
          "41": {},
          "42": {},
          "43": {},
          "44": {},
          "45": {},
          "46": {},
          "47": {},
          "48": {},
          "49": {},
          "50": {},
          "51": {},
          "52": {},
          "53": {
            "is_mandatory": true,
            "go_to": [54],
            "save_checkpoint": true
          },
          "54": {
            "is_mandatory": true,
            "go_to": [55],
          },
          "55": {
            "is_mandatory": true,
            "go_to": [56],
          },
          "56": {
            "is_mandatory": true,
            "go_to": [57],
          },
          "57": {
            "is_mandatory": true,
            "go_to": [58],
          },
          "58": {
            "is_mandatory": true,
            "go_to": [59],
          },
          "59": {
            "is_mandatory": true,
            "go_to": [60],
          },
          "60": {
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Yes"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 60
            },
            "static_params": {
              "value_t": [61],
              "value_f": [62]
            },
            "dependent_questions": [61, 62]
          },
          "61": {
            "is_mandatory": true,
            "go_to": 62
          },
          "62": {
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Yes"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 62
            },
            "static_params": {
              "value_t": [63],
              "value_f": [64]
            },
            "dependent_questions": [63, 64]
          },
          "63": {
            "is_mandatory": true,
            "go_to": 64
          },
          "64": {
            "requires_check": true,
            "jump_logic": {
              "if": [{
                "==": [{
                  "var": "value"
                }, "Yes"]
              }, {
                "var": "value_t"
              }, {
                "var": "value_f"
              }]
            },
            "dynamic_params": {
              "value": 64
            },
            "static_params": {
              "value_t": [65],
              "value_f": [66]
            },
            "dependent_questions": [65, 66],
            "save_checkpoint": true
          },
          "65": {
            "is_mandatory": true,
            "go_to": 66
          },
          "66": {
            "is_mandatory": true,
            "go_to": 67
          },
          "67": {
            "is_mandatory": true,
            "go_to": 68
          },
          "68": {
            "go_to": 69
          },
          "69": {
            "is_mandatory": true,
            "go_to": 70
          },
          "70": {
            "submit": true
          }
        }
      }

      render :json => { :questions => Questionnaire.all, :logic => logic, :status => :ok }

      # render :json => { :questions => get_questionnaire[:questionnaire], :logic => get_questionnaire[:questionnaire_logic], :status => 200 }
    elsif params[:scope] == 'save'
      # @response.update({ :responses => params[:answers] });
      render :json => { status => 204 }
    end
  end

end
