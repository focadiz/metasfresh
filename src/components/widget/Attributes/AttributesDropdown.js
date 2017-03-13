import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import onClickOutside from 'react-onclickoutside';

import RawWidget from '../RawWidget';

import {
    findRowByPropName
} from '../../../actions/WindowActions'

class AttributesDropdown extends Component {
    constructor(props) {
        super(props);

        this.state = {
            shouldPropagateClickOutside: false,
            focused: false
        }
    }

    componentWillReceiveProps = () => {
        const {shouldPropagateClickOutside} = this.state;

        if(shouldPropagateClickOutside){
            const {onClickOutside} = this.props;

            this.setState({
                shouldPropagateClickOutside: false
            }, () => onClickOutside());
        }
    }

    handleClickOutside = () => {
        const {onClickOutside} = this.props;
        const {focused} = this.state;

        //we need to blur all fields, to patch them before completion
        this.dropdown.focus();

        //we need to wait for fetching all of PATCH fields on blur
        //to complete on updated instance
        if(!focused){
            return onClickOutside();
        }

        this.setState({
            shouldPropagateClickOutside: true
        })
    }

    handleFocus = () => {
        this.setState({
            focused: true
        })
    }

    handlePatch = (prop, value, attrId) => {
        const {handlePatch, onClickOutside} = this.props;

        handlePatch(prop, value, attrId, () => {
            const {focused, shouldPropagateClickOutside} = this.state;
            if (!focused && shouldPropagateClickOutside){
                onClickOutside();
            }

            this.setState({
                focused: false
            });
        });
    }

    handleBlur(willPatch){
        const clickedOutside = this.state.shouldPropagateClickOutside;
        const { onClickOutside } = this.props;

        if (!willPatch && !clickedOutside){
            return;
        }

        this.setState({
            focused: false,
            shouldPropagateClickOutside: clickedOutside
        }, () => {
            if (!willPatch){
                onClickOutside();
            }
        });
    }

    renderFields = () => {
        const {
            tabIndex, layout, data, attributeType, handleChange, attrId
        } = this.props;

        if(layout){
            return layout.map((item, id) => {
                const widgetData = item.fields.map(elem => findRowByPropName(data, elem.field));
                return (<RawWidget
                    entity={attributeType}
                    widgetType={item.widgetType}
                    fields={item.fields}
                    dataId={attrId}
                    widgetData={widgetData}
                    gridAlign={item.gridAlign}
                    key={id}
                    type={item.type}
                    caption={item.caption}
                    handleBlur={(patch) => this.handleBlur(patch)}
                    handlePatch={(prop, value) => this.handlePatch(prop, value, attrId)}
                    handleFocus={this.handleFocus}
                    handleChange={handleChange}
                    tabIndex={tabIndex}
                />)
            })
        }
    }

    render() {
        return (
            <div
                className="attributes-dropdown panel-shadowed panel-primary panel-bordered panel-spaced"
                ref={c => {this.dropdown = c; c && c.focus()}}
            >
                {this.renderFields()}
            </div>
        )
    }
}

AttributesDropdown.propTypes = {
    dispatch: PropTypes.func.isRequired
};

AttributesDropdown = connect(
    state => ({
        pendingIndicator: state.windowHandler.indicator
    })
)(onClickOutside(AttributesDropdown))

export default AttributesDropdown
